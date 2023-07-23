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
    sender = UserPublicSerializer(source='host',read_only=True)
    room = ChatRoomPublicSerializer(source='chat_room',read_only=True)

    class Meta:
        model = Message
        fields = [
            'id',
            'message_url',
            'edit_url',
            'room',
            'sender',
            'description',

            'updated',
            'created',
        ]

      


class ChatRoomSerializer(ModelSerializer):
    owner = UserPublicSerializer(source='host',read_only=True)
    last_message = SerializerMethodField(read_only=True)
    participants = SerializerMethodField(read_only=True)

    class Meta:
        model = ChatRoom
        fields = [
            'id',
            'owner',
            'participants',
            'name',
            'description',
            'last_message',
            'updated',
            'timestamp',
        ]

        extra_kwargs = {
            'participants' : {'read_only': True},
        }

    def get_last_message(self, obj):
        linked_messages = obj.message_set.all()
        last_mss_qs = linked_messages.distinct().first() or None

        if last_mss_qs is not None:
            return last_mss_qs.description

        return None
    
    def get_participants(self, obj):
        return [participant.phone_number for participant in obj.participants.all()]

