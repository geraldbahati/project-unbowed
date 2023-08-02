from django.urls import path
from .views import VerifyOTPView, SendOTPView, UserView, GenerateSessionIdForQRcodeView, CheckQRCodeAuthenticationView, AuthenticateQRCodeView, VerifyTokenView
from rest_framework_simplejwt.views import TokenRefreshView

urlpatterns = [
    path('send-otp/', SendOTPView.as_view(), name='send-otp'),
    path('verify-otp/', VerifyOTPView.as_view(), name='verify-otp'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('token/has-expired/', VerifyTokenView.as_view(), name='token_has_expired'),


    path('', UserView.as_view(), name='user'),
    path('request-session/', GenerateSessionIdForQRcodeView.as_view(), name='request-session'),
    path('check-session/', CheckQRCodeAuthenticationView.as_view(), name='check-session'),
    path('authenticate/', AuthenticateQRCodeView.as_view(), name='authenticate'),
]