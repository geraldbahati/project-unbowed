from django.urls import re_path

from chat.consumers import ChatConsumer

websocket_urlpatterns = [
    re_path(r"^notifications/(?P<chatroom_id>\w+)/$", ChatConsumer.as_asgi(), name="message_notifier"),
]