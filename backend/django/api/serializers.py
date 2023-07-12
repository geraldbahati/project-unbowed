from rest_framework import serializers

class UserPublicSerializer(serializers.Serializer):
    username = serializers.CharField(read_only=True)
    id = serializers.IntegerField(read_only=True)


class CoursePublicDetialSerializer(serializers.Serializer):
    course_name = serializers.CharField(read_only = True)
    id = serializers.IntegerField(read_only=True)

