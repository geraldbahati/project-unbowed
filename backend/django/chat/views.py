
from django.shortcuts import render
from rest_framework.generics import RetrieveAPIView, ListCreateAPIView, UpdateAPIView, DestroyAPIView
from django.http import Http404

from user.models import CustomUser
from .models import Message, ChatRoom

from .serializers import MessageSerializer, ChatRoomSerializer
from api.mixins import StaffEditorPermissionMixin, OwnerOrReadOnlyPermissionMixin, AuthorisedPermissionMixin

# Create your views here.


class ChatRoomListCreateAPIView(ListCreateAPIView, AuthorisedPermissionMixin):
    queryset = ChatRoom.objects.all()
    serializer_class = ChatRoomSerializer

    def perform_create(self, serializer):
        # course_chatroom = serializer.validated_data.get('optional_tied_course')
        host = self.request.user

        participants = CustomUser.objects.filter(
            course_name=host.course_name).exclude(id=host.id) or None
        

        serializer.save(
            host=host,
            participants=participants,
        )

        serializer.save()


class ChatRoomDetailAPIView(ListCreateAPIView, AuthorisedPermissionMixin):
    serializer_class = MessageSerializer

    def get_queryset(self):
        chatroom = self.get_object()

        # gets all the message linked to the active chatroom
        message_qs = chatroom.message_set.all()
        return message_qs

    def get_object(self):
        room_id = self.kwargs.get('chatroom_id')
        chatroom = ChatRoom.objects.filter(id=room_id).first() or None

        if chatroom is not None:
            return chatroom

    def perform_create(self, serializer):
        chat_room = self.get_object()
        host = self.request.user
        topic = serializer.validated_data.get("topic") or None
        print(topic)
        description = serializer.validated_data.get("describe")

        if topic is None:
            topic = description[0:20] + "..."

        serializer.save(chat_room=chat_room, host=host, topic=topic)

        serializer.save()


class ChatRoomDestroyAPIView(DestroyAPIView, StaffEditorPermissionMixin):
    queryset = ChatRoom.objects.all()
    serializer_class = ChatRoomSerializer

    def perform_destroy(self, instance):
        return super().perform_destroy(instance)


class MessageDetailAPIView(RetrieveAPIView, AuthorisedPermissionMixin):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer


class MessageUpdateAPIView(UpdateAPIView, OwnerOrReadOnlyPermissionMixin, AuthorisedPermissionMixin):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer

    def perform_update(self, serializer):
        host = serializer.validated_data.get("host") or None
        if host is None:
            host = self.request.user
        serializer.save(host=host)


class MessageDestroyAPIView(DestroyAPIView, AuthorisedPermissionMixin):
    queryset = Message.objects.all()
    serializer_class = MessageSerializer

    def perform_destroy(self, instance):
        return super().perform_destroy(instance)


def index(request):
    return render(request, 'chat/index.html', {})


def room(request, room_name):
    return render(request, 'chat/chatroom.html', {
        'room_name': room_name
    })
