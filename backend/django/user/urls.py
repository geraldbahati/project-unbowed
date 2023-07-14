from django.urls import path
from .views import SignUpView, LogInView, LogOutView, UserAPI

urlpatterns = [
    path('signup/', SignUpView.as_view(), name='signup'),
    path('login/', LogInView.as_view(), name='login'),
    path('logout/', LogOutView.as_view(), name='logout'),
    path('', UserAPI.as_view(), name='user'),
]