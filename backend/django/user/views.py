from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.generics import RetrieveAPIView, GenericAPIView



from .utils import send_otp_sms,verify_otp
from .serializers import UserSerializer, SendOTPSerializer, VerifyOTPSerializer
from .models import CustomUser


class SendOTPView(GenericAPIView):
    """
    Send an OTP code to the user's phone number.
    """
    permission_classes = [AllowAny]
    serializer_class = SendOTPSerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            phone_number = serializer.validated_data['phone_number']

            # Send the OTP code
            if send_otp_sms(phone_number):
                return Response({
                    'message': 'OTP code sent.'   
                }, status=status.HTTP_200_OK)
            else:
                return Response({'error': 'Failed to send OTP code.'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        


class VerifyOTPView(GenericAPIView):
    """
    Verify the OTP code sent to the user's phone number.
    Create a new user or update the existing one.
    Give the user a new access token and a new refresh token.
    """
    permission_classes = [AllowAny]
    serializer_class = VerifyOTPSerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            phone_number = serializer.validated_data['phone_number']
            otp = serializer.validated_data['verification_code']
            

            sid = verify_otp(phone_number, otp)

            # Verify the OTP code
            if sid:
                # If the OTP code is valid, create a new user or update the existing one
                user, created = CustomUser.objects.get_or_create(phone_number=phone_number)
                if created:
                    user.username = phone_number
                    user.uid = sid
                    user.save()

                refresh = RefreshToken.for_user(user)
                user.access_token = str(refresh.access_token)
                user.refresh_token = str(refresh)

                response = {
                    "user": UserSerializer(user, context=self.get_serializer_context()).data,
                    "tokens": {
                        "refresh": str(refresh),
                        "access": str(refresh.access_token),
                    },
                }
                return Response(response)
            else:
                return Response({'error': 'Invalid OTP code.'}, status=status.HTTP_400_BAD_REQUEST)

    