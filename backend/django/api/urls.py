from django.urls import path, include
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
from .views import MyProtectedView

urlpatterns = [
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
     path('protected/', MyProtectedView.as_view(), name='my_protected_view'),

    path('chat/', include('chat.urls')),
    path('user/', include('user.urls')),
]