from django.urls import path, re_path
from . import views

urlpatterns = [
    
    # re_path(r'messages/(?P<user_id>\w+)/(?P<target_name>\w+)/$', views.MessageListCreateAPIView.as_view(), name="messages-list-api"),
    path('messages/', views.MessageListCreateAPIView.as_view(), name="messages-list-api"),
    path('message/<str:pk>/', views.MessageDetailAPIView.as_view(), name="message-detail-api"),
    path('update-message/<str:pk>', views.MessageUpdateAPIView.as_view(), name="message-update-api"),
    path('delete-message/<str:pk>/', views.MessageDestroyAPIView.as_view(), name = "message-delete-api"),

    path('chatrooms/', views.ChatRoomListCreateAPIView.as_view(), name="chatrooms-list-api"),
    re_path(r'chatroom/(?P<chatroom_id>\w+)/$', views.ChatRoomDetailAPIView.as_view(), name="chatroom-detail-api"),
    path('delete-chatroom/<str:pk>/', views.MessageDestroyAPIView.as_view(), name = "delete-delete-api"),
]