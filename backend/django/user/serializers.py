
from .models import CustomUser

from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from django.contrib.auth import authenticate
from api.serializers import CoursePublicDetialSerializer


class UserSerializer(serializers.ModelSerializer):
    course = CoursePublicDetialSerializer(source='course_name',read_only=True)
    class Meta:
        model = CustomUser
        fields = ['id', 'email', 'username', 'course', 'is_staff']



class RegisterSerializer(serializers.ModelSerializer):
  

    password = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = CustomUser
        fields = (
          
            'username', 
            # 'course_name',
            'password', 
            'password2'
        )
        extra_kwargs = {
            'email' : {'write_only': True},
            'password' : {'write_only': True},
            'password2' : {'write_only': True},
        }

    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Password fields didn't match."})

        return attrs

    def create(self, validated_data):
        user = CustomUser.objects.create(
            username=validated_data['username'],
            email=validated_data['email'],
            # course_name = validated_data['course_name'],
        )

        
        user.set_password(validated_data['password'])
        user.save()

        return user


class LoginSerializer(serializers.Serializer):
    
    password = serializers.CharField()

    def validate(self, data):
        user = authenticate(**data)
        if user and user.is_active:
            return user

        raise serializers.ValidationError("Incorrect Credentials")


class EmailVerificationSerializer(serializers.ModelSerializer):
    token = serializers.CharField(max_length=555)

    class Meta:
        model = CustomUser
        fields = ['token']