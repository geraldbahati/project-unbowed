from django.db.models import Q
from rest_framework.serializers import ModelSerializer, SerializerMethodField
from api.serializers import UserPublicSerializer, ChatRoomPublicSerializer
from rest_framework import serializers
from .models import Message, ChatRoom


class MessageSerializer(ModelSerializer):
    message_url = serializers.HyperlinkedIdentityField(
        view_name="message-detail-api")
    edit_url = serializers.HyperlinkedIdentityField(
        view_name="message-update-api")
    sender = UserPublicSerializer(source='host', read_only=True)
    room = ChatRoomPublicSerializer(source='chat_room', read_only=True)
    message_type = serializers.ChoiceField(
        choices=Message.FILE_TYPE_CHOICES, read_only=False)

    class Meta:
        model = Message
        fields = [
            'id',
            'message_url',
            'edit_url',
            'chat_room',
            'room',
            'sender',
            'text_content',
            'message_type',
            'file',  # Ensure you handle permissions/security correctly.   
            'status',
            'read',
            'updated',
            'created_at',
        ]

        extra_kwargs = {
            'chat_room' : {'write_only': True},
        }
    
    def validate(self, data):
        """
        Ensure that the sender is a participant in the chat room.
        """
        chat_room = data.get('chat_room')
        sender = data.get('sender')

        if not chat_room.is_participant(sender):
            raise serializers.ValidationError(
                "You are not a participant in this chat room.")

        return data
       


class ChatRoomSerializer(ModelSerializer):
    owner = UserPublicSerializer(source='host', read_only=True)
    last_message = SerializerMethodField(read_only=True)
    participants = SerializerMethodField(read_only=True)
    admins = SerializerMethodField(read_only=True)
    chat_type = serializers.ChoiceField(
        choices=ChatRoom.CHAT_TYPE_CHOICES, read_only=True)

    class Meta:
        model = ChatRoom
        fields = [
            'id',
            'owner',
            'participants',
            'admins',
            'name',
            'description',
            'topic',
            'chat_type',
            'last_message',
            'last_message_read_time',
            'updated',
            'created_at',
        ]
        extra_kwargs = {
            'owner': {'read_only': True},
            'last_message_read_time': {'read_only': True},
            'participants': {'read_only': True},
        }

    def get_last_message(self, obj):
        linked_messages = obj.message_set.all()
        last_mss_qs = linked_messages.distinct().first() or None

        if last_mss_qs is not None:
            if last_mss_qs.message_type == Message.AUDIO:
                return f'{last_mss_qs.sender.phone_number} sent an Audio'
            elif last_mss_qs.message_type == Message.IMAGE:
                return f'{last_mss_qs.sender.phone_number} sent an Image'
            elif last_mss_qs.message_type == Message.VIDEO:
                return f'{last_mss_qs.sender.phone_number} sent a Video'
            elif last_mss_qs.message_type == Message.DOCUMENT:
                return f'{last_mss_qs.sender.phone_number} sent a Document'

            return last_mss_qs. text_content

        return None

    def get_participants(self, obj):
        return [participant.phone_number for participant in obj.participants.all()]

    def get_admins(self, obj):
        return [admin.phone_number for admin in obj.admins.all()]
