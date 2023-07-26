
from .models import CustomUser

from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
from django.contrib.auth import authenticate


class UserSerializer(serializers.ModelSerializer):
     class Meta:
        model = CustomUser
        fields = ['id', 'phone_number', 'username', 'is_staff']



class RegisterSerializer(serializers.ModelSerializer):
  

    password = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = CustomUser
        fields = (
          
            'username', 
            'phone_number',
            'password', 
            'password2'
        )
        extra_kwargs = {
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
            phone_number=validated_data['phone_number'],
        )

        user.set_password(validated_data['password'])
        user.save()

        return user
    

class LoginSerializer(serializers.Serializer):
    password = serializers.CharField(write_only=True, required=True)

    class Meta:
        model = CustomUser
        fields = ('phone_number', 'password')

        extra_kwargs = {
            'password' : {'write_only': True},
        }


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




class SendOTPSerializer(serializers.Serializer):
    phone_number = serializers.CharField(max_length=15)



class VerifyOTPSerializer(serializers.Serializer):
    phone_number = serializers.CharField(max_length=15)
    verification_code = serializers.CharField(max_length=6)
    secret_key = serializers.CharField(max_length=255)


class AuthenticateQRCodeSerializer(serializers.Serializer):
    session_id = serializers.CharField(max_length=255)


