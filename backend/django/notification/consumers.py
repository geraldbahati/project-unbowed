from channels.generic.websocket import AsyncWebsocketConsumer
import json
from channels.db import database_sync_to_async
from asgiref.sync import sync_to_async

from chat.models import Message
from chat.models import ChatRoom
from user.models import CustomUser


class ChatConsumer(AsyncWebsocketConsumer):
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
        text_data_json = json.loads(text_data)
        action = text_data_json['action']

        if action == 'send-message':
            message = text_data_json['message']
            # username = text_data_json['username']
            username = self.user.username
           
            created = await self.create_message_object(self.user, message)

            # Send message to room group
            await self.channel_layer.group_send(
                self.room_group_name,
                {
                    'type': 'chatroom_message',
                    'message': message,
                    'username': username,
                    'created': created.astimezone().__str__(),
                }
            )

        if action == 'typing':
            # broadcast to the group that someone is typing

            username = self.user.username
            await self.channel_layer.group_send(
                self.room_group_name,
                {
                    'type': 'chatroom_typing',
                    'username': username,
                }
            )

    async def chatroom_message(self, event):
        message = event['message']
        username = event['username']
        created = event['created']

        await self.send(text_data=json.dumps({
            'action': 'receive-message',
            'message': message,
            'username': username,
            'created': created,
        }))

    async def chatroom_typing(self, event):
        username = event['username']

        await self.send(text_data=json.dumps({
            'action': 'typing',
            'username': username,
        }))

   
    # async def send_online_users(self):
    #     online_users = await self.get_online_users()

    #     usernames = await sync_to_async([user.username for user in online_users], thread_sensitive=True)

    #     await self.send(text_data=json.dumps({
    #         'action': 'online_users',
    #         'users': usernames
    #     }))

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

    @database_sync_to_async
    def get_chatroom(self, loggedin_params, lookup_params):
        loggedin_user = CustomUser.objects.get(id=loggedin_params)

        other_user = CustomUser.objects.filter(username=lookup_params) or None

        if other_user is not None:
            obj, created = ChatRoom.objects.get_or_new(
                    loggedin_user, 
                    other_user
                )
            
        return obj

    @database_sync_to_async
    def create_message_object(self, host, message):
        chat_room = self.chat_room

        obj = Message.objects.create(
            chat_room=chat_room,
            host=host,
            description=message,
        )

        return obj.created

