from channels.testing import WebsocketCommunicator
from channels.routing import URLRouter
from django.test import TestCase
from django.contrib.auth import get_user_model
from django.conf.urls import url
from channels.auth import AuthMiddlewareStack
from unittest.mock import ANY

from chat.consumers import ChatConsumer
from chat.models import ChatRoom

class ChatConsumerTest(TestCase):

    async def setUp(self):
        # Create your user here
        self.user = get_user_model().objects.create_user(username='testuser', password='12345')
        self.chat_room = ChatRoom.objects.create(host=self.user)
        
        application = URLRouter([
            url(r'ws/chat/(?P<chatroom_id>\w+)/$', AuthMiddlewareStack(ChatConsumer.as_asgi()))
        ])
        self.communicator = WebsocketCommunicator(application, f"/ws/chat/{self.chat_room.id}/")
        self.communicator.scope['user'] = self.user
        connected, _ = await self.communicator.connect()
        assert connected is True

    async def tearDown(self):
        await self.communicator.disconnect()

    async def test_receive_message(self):
        # Test sending a message to the room group
        await self.communicator.send_json_to({
            'action': 'send-message',
            'message': 'Hello',
        })

        response = await self.communicator.receive_json_from()
        self.assertEqual(response, {
            'message': 'Hello',
            'username': 'testuser',
            # You may need to modify this test to match the exact output
            # of the created field in your consumer.
            'created': ANY,
        })

    async def test_typing(self):
        # Test sending a typing notification to the room group
        await self.communicator.send_json_to({
            'action': 'typing',
        })

        response = await self.communicator.receive_json_from()
        self.assertEqual(response, {
            'action': 'typing',
            'username': 'testuser',
        })


