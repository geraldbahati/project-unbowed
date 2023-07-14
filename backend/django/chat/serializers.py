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
            # 'optional_tied_course' : {'write_only': True},
            
            'participants' : {'read_only': True},
        }

    def get_last_message(self, obj):
        linked_messages = obj.message_set.all()
        course_lookup = Q(host=obj.host)
        last_mss_qs = linked_messages.filter(course_lookup).distinct().first() or None

        if last_mss_qs is not None:
            return last_mss_qs.description

        return None

