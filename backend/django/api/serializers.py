from rest_framework import serializers

class UserPublicSerializer(serializers.Serializer):
    phone_number = serializers.CharField(read_only=True)
    username = serializers.CharField(read_only=True)


class ChatRoomPublicSerializer(serializers.Serializer):
    name = serializers.CharField(read_only=True)
    host = UserPublicSerializer(read_only=True)