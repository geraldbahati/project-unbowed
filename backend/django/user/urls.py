from django.urls import path
from .views import VerifyOTPView, SendOTPView, UserView

urlpatterns = [
    path('send-otp/', SendOTPView.as_view(), name='send-otp'),
    path('verify-otp/', VerifyOTPView.as_view(), name='verify-otp'),
    path('', UserView.as_view(), name='user'),
]