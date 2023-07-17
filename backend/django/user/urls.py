from django.urls import path
from .views import VerifyOTPView, SendOTPView

urlpatterns = [
    path('send-otp/', SendOTPView.as_view(), name='send-otp'),
    path('verify/', VerifyOTPView.as_view(), name='verify-otp'),
]