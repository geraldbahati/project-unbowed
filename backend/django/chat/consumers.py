from channels.generic.websocket import AsyncWebsocketConsumer
import json
import asyncio
from channels.db import database_sync_to_async
from asgiref.sync import sync_to_async
from django.core.exceptions import ValidationError

from .models import Message, ChatRoom
from .serializers import MessageSerializer, ChatRoomSerializer
from user.models import CustomUser


class ChatConsumer(AsyncWebsocketConsumer):
    typing_timeout = {}

    async def connect(self):
        # room_name represents the chatroom
        # get the params passed in from the url
        self.room_id = self.scope['url_route']['kwargs']['chatroom_id']
        self.chat_room = await self.get_chatroom_object(room_id=self.room_id)

        self.user = self.scope['user']
        await self.update_user_status(self.user, True)

        self.room_name = f'chatroom_{self.chat_room.id}'
        self.room_group_name = 'chat_%s' % self.room_name

        # await self.send_online_users()

        # Join room group
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )

        await self.accept()

    async def disconnect(self, close_code):
        # Update user status to offline
        await self.update_user_status(self.user, False)

        # await self.send_online_users()

        # Leave room group
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    async def receive(self, text_data):
        '''
        text_data - JSON data sent from the frontend

        Example:
            {
                "action": "send-message",
                "message_type": "text",
                "message_content": "Hello, how are you?"
            }


        '''
        text_data_json = json.loads(text_data)
        action = text_data_json['action']

        if action == 'send-message':
            message_type = text_data_json.get('message_type', 'text') # default to 'text' if not provided
            message_content = text_data_json['message_content']
            
            # Create message object
            message = await self.create_message_object(
                sender=self.user,
                message_type=message_type,
                message_content=message_content
            )

            # Serialize the message object
            serialized_message = await self.serialize_message(message)

            # Send message to room group
            await self.channel_layer.group_send(
                self.room_group_name,
                {
                    'type': 'chatroom_message',
                    'message': serialized_message,
                }
            )

            # Notify the chatroom list group for the current user
            await self.channel_layer.group_send(
                f'chatroom_list_group_{self.room_id}',
                {
                    'type': 'chatroom_update',
                    'chatroom_id': self.room_id,
                }
            )
            
        if action == 'start_typing':
            # Cancel the timeout if it exists
            if self.user.username in self.typing_timeouts:
                self.typing_timeouts[self.user.username].cancel()

            # Notify the chatroom group that the user is typing
            await self.channel_layer.group_send(
                self.room_group_name,
                {
                    'type': 'chatroom_typing',
                    'action': 'start_typing',
                    'username': self.user.username,
                }
            )

            # Set a timeout to notify the chatroom group that the user has stopped typing
            self.typing_timeouts[self.user.username] = asyncio.get_event_loop().call_later(
                5, 
                lambda: asyncio.create_task(self.stop_typing_timeout(self.user.username))
            )

        elif action == 'stop_typing':
            # If user stops typing, cancel the timeout
            if self.user.username in self.typing_timeouts:
                self.typing_timeouts[self.user.username].cancel()
                del self.typing_timeouts[self.user.username]

            # Notify the chatroom group that the user has stopped typing
            await self.channel_layer.group_send(
                self.room_group_name,
                {
                    'type': 'chatroom_typing',
                    'action': 'stop_typing',
                    'username': self.user.username,
                }
            )

    async def stop_typing_timeout(self, username):
        # Notify the group that this user has stopped typing
        await self.channel_layer.group_send(
            self.room_group_name,
            {
                'type': 'chatroom_typing',
                'action': 'stop-typing',
                'username': username,
            }
        )

        # Remove user from the typing timeouts dictionary
        del self.typing_timeouts[username]

    async def chatroom_message(self, event):
        message = event['message']

        # Send message to WebSocket
        await self.send(text_data=json.dumps({
            'action': 'receive-message',
            'message': message
        }))

    async def chatroom_typing(self, event):
        action = event['action']
        username = event['username']

        await self.send(text_data=json.dumps({
            'action': action,
            'username': username,
        }))

   
    async def send_online_users(self):
        online_users = await self.get_online_users()

        usernames = await sync_to_async(self.get_usernames)(online_users)

        await self.send(text_data=json.dumps({
            'action': 'online_users',
            'users': usernames
        }))

    def get_usernames(online_users):
        return [user.username for user in online_users]

    @database_sync_to_async
    def get_online_users(self):
        return CustomUser.objects.filter(is_online=True)

    @database_sync_to_async
    def update_user_status(self, user, is_online):
        user.is_online = is_online
        user.save()

    @database_sync_to_async
    def get_chatroom_object(self, room_id):
        chatroom = ChatRoom.objects.filter(id=room_id).first() or None

        if chatroom is not None:
            return chatroom
        else:
            raise Exception('Chatroom does not exist')

    @database_sync_to_async
    def create_message_object(self, sender, message_type, message_content):
        message_kwargs = {
            'chat_room': self.chat_room,
            'sender': sender,
            'message_type': message_type
        }

        if message_type == 'text':
            message_kwargs['text_content'] = message_content.get('text')
        elif message_type == 'audio':
            message_kwargs['audio_file'] = message_content.get('audio_file')
        elif message_type == 'image':
            message_kwargs['image_file'] = message_content.get('image_file')
        elif message_type == 'video':
            message_kwargs['video_file'] = message_content.get('video_file')

        message = Message.objects.create(**message_kwargs)
        return message
    
    @database_sync_to_async
    def serialize_message(self, message):
        # Serialize the message object
        serialized_data = MessageSerializer(message).data
        return serialized_data


class ChatroomConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.user_id = self.scope['user'].id
        
        # Fetch all the chatrooms of the current user
        self.chatroom_ids = await self.get_user_chatroom_ids(self.user_id)

        # Join the chatroom list group
        for chatroom_id in self.chatroom_ids:
            group_name = f'chatroom_list_group_{chatroom_id}'

            # Join each chatroom list group
            await self.channel_layer.group_add(
                group_name,
                self.channel_name
            )

        await self.accept()

    async def disconnect(self, close_code):
        # Remove the user from the chatroom list group they were part of
        for chatroom_id in self.chatroom_ids:
            group_name = f'chatroom_list_group_{chatroom_id}'

            # Leave each chatroom list group
            await self.channel_layer.group_discard(
                group_name,
                self.channel_name
            )


    async def receive(self, text_data):
        pass

    async def chatroom_update(self, event):
        chatroom_id = event['chatroom_id']

        # Send update to frontend
        await self.send(text_data=json.dumps({
            'action': 'chatroom_update',
            'chatroom_id': chatroom_id,
        }))


    @database_sync_to_async
    def get_user_chatroom_ids(self, user_id) -> list:
        chatrooms = ChatRoom.objects.filter(participants__id=user_id)

        chatroom_ids = [chatroom.id for chatroom in chatrooms]

        return chatroom_ids
