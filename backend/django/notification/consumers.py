from channels.generic.websocket import AsyncWebsocketConsumer
import json
from channels.db import database_sync_to_async

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
        self.room_name = f'chatroom_{self.chat_room.id}'
        self.room_group_name = 'chat_%s' % self.room_name

        # Join room group
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )

        await self.accept()

    async def disconnect(self, close_code):
        # Leave room group
        await self.channel_layer.group_discard(
            self.room_group_name,
            self.channel_name
        )

    async def receive(self, text_data):
        text_data_json = json.loads(text_data)
        message = text_data_json['message']
        # username = text_data_json['username']
        username = self.user.username
        print(self.user)
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

    async def chatroom_message(self, event):
        message = event['message']
        username = event['username']
        created = event['created']

        await self.send(text_data=json.dumps({
            'message': message,
            'username': username,
            'created': created,
        }))



    @database_sync_to_async
    def get_chatroom_object(self, room_id):
        chatroom = ChatRoom.objects.filter(id=room_id).first() or None

        if chatroom is not None:
            return chatroom

    @database_sync_to_async
    def get_chatroom(self, loggedin_params, lookup_params):
        loggedin_user = CustomUser.objects.get(id=loggedin_params)
        # course = Course.objects.filter(course_name=lookup_params) or None
        participants = CustomUser.objects.filter(
            course_name=loggedin_user.course_name).exclude(id=loggedin_params) or None

        other_user = CustomUser.objects.filter(username=lookup_params) or None

        # if course is not None:
        #     obj, created = ChatRoom.objects.get_or_new_course_chat_room(
        #         course.first(), loggedin_user, participants)

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
            topic=message,
            describe=message,
        )

        return obj.created

