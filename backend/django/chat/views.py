
from django.shortcuts import render
from rest_framework.generics import RetrieveAPIView, ListCreateAPIView, UpdateAPIView, DestroyAPIView
from rest_framework_simplejwt.authentication import JWTAuthentication

from user.models import CustomUser
from .models import Message, ChatRoom

from .serializers import MessageSerializer, ChatRoomSerializer
from api.mixins import StaffEditorPermissionMixin, OwnerOrReadOnlyPermissionMixin, AuthorisedPermissionMixin

# Create your views here.


class ChatRoomListCreateAPIView(ListCreateAPIView, AuthorisedPermissionMixin):
    queryset = ChatRoom.objects.all()
    serializer_class = ChatRoomSerializer
    authentication_classes = [JWTAuthentication]


    def get_queryset(self):
        print(self.request.user)
        return super().get_queryset()
    
    def perform_create(self, serializer):
        host = self.request.user

        participants = CustomUser.objects.all().exclude(id=host.id) or None
        
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
        description = serializer.validated_data.get("description")

        serializer.save(chat_room=chat_room, host=host, description=description)


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


class MessageListCreateAPIView(ListCreateAPIView, AuthorisedPermissionMixin):
    serializer_class = MessageSerializer

    def get_queryset(self):
        
        message_qs = Message.objects.all()
        return message_qs

    def perform_create(self, serializer):
        user = self.request.user
        # target_name = self.kwargs.get('target_name')
        #! TODO have to work on this
        chat_room = ChatRoom.objects.get(id=1) or None
        serializer.save(host=user, chat_room=chat_room)