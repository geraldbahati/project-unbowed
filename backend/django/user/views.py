from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.generics import RetrieveAPIView, GenericAPIView
from django.core.cache import cache



from .utils import generate_and_send_otp, verify_otp, generate_session_id
from .serializers import UserSerializer, SendOTPSerializer, VerifyOTPSerializer, AuthenticateQRCodeSerializer
from .models import CustomUser
from api.mixins import AuthorisedPermissionMixin


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

            # Generate and send the OTP code
            if generate_and_send_otp(phone_number):
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
           

            # Verify the OTP code
            if verify_otp(phone_number=phone_number, otp=otp):
                # If the OTP code is valid, create a new user or update the existing one
                print("verified")
                user, created = CustomUser.objects.get_or_create(phone_number=phone_number)
                if created:
                    user.username = phone_number
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
            
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UserView(RetrieveAPIView):
    """
    Get the user's data.
    """
    permission_classes = [IsAuthenticated]
    serializer_class = UserSerializer

    def get_object(self):
        return self.request.user
    


class GenerateSessionIdForQRcodeView(APIView):
    """
    Generate a unique session ID for QR code authentication.
    """
    permission_classes = [AllowAny]

    def get(self, request):
        # Generate a unique session ID
        session_id = generate_session_id()

        # Cache the session ID with a timeout of 5 minutes
        cache.set(session_id, None, timeout=300)

        return Response({'session_id': session_id})
    


class AuthenticateQRCodeView(GenericAPIView, AuthorisedPermissionMixin):
    """
    Authenticate a user using a QR code.
    """

    serializer_class = AuthenticateQRCodeSerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        if serializer.is_valid():
            session_id = serializer.validated_data['session_id']
            user = self.request.user

            if user.is_authenticated:
                refresh = RefreshToken.for_user(user)

                # Associate the session ID with the user's tokens
                cache.set(session_id, refresh)

                return Response({'status': 'success'}, status=status.HTTP_200_OK)
              
            else:
                return Response({'error': 'User not authenticated.'}, status=status.HTTP_400_BAD_REQUEST)
            

        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

          
class CheckQRCodeAuthenticationView(APIView):
    """
    Check if a user has been authenticated using a QR code.
    """
    permission_classes = [AllowAny]

    def get(self, request, session_id):
        # Retrieve the access token associated with the session ID
        refresh = cache.get(session_id)

        if refresh is None:
            return Response({'error': 'User not authenticated.'}, status=status.HTTP_400_BAD_REQUEST)
        else:
            user = refresh.user
            access_token = str(refresh.access_token)
            refresh_token = str(refresh)

            response = {
                "user": UserSerializer(user, context=self.get_serializer_context()).data,
                "tokens": {
                    "refresh": refresh_token,
                    "access": access_token,
                },
            }

            return Response(response, status=status.HTTP_200_OK)


class VerifyTokenView(APIView, AuthorisedPermissionMixin):
    """
    Verify the user's access token.
    """
    def get(self, request):
        return Response({'status': 'success'}, status=status.HTTP_200_OK)