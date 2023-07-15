from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework.generics import RetrieveAPIView, GenericAPIView


from .serializers import UserSerializer, RegisterSerializer
from .models import CustomUser

class SignUpView(GenericAPIView):
    permission_classes = [AllowAny]
    serializer_class = RegisterSerializer

    def post(self, request):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
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



class LogInView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        phone_number = request.data.get('phone_number')
        password = request.data.get('password')
        if phone_number and password:
            user = CustomUser.objects.filter(phone_number=phone_number).first()
            if user and user.check_password(password):
                refresh = RefreshToken.for_user(user)
                response = {
                    "user": UserSerializer(user, context=self.get_serializer_context()).data,
                    "tokens": {
                        "refresh": str(refresh),
                        "access": str(refresh.access_token),
                    },
                }
            return Response(response)
        return Response({'error': 'Invalid credentials'}, status=400)

class LogOutView(APIView):
    permission_classes = [AllowAny]

    def post(self, request):
        try:
            refresh_token = request.data['refresh_token']
            token = RefreshToken(refresh_token)
            token.blacklist()
        except KeyError:
            pass
        return Response({'detail': 'Successfully logged out.'})
    

class UserAPI(RetrieveAPIView):
    permission_classes = [
        IsAuthenticated,
    ]

    serializer_class = UserSerializer

    def get_object(self):
        return self.request.user
