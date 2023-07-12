from django.db import models
from django.db.models import Q

from user.models import CustomUser

# Create your models here.

class ChatRoom(models.Model):
    host = models.ForeignKey(
        CustomUser, on_delete=models.CASCADE, related_name='host')
    participants = models.ManyToManyField(CustomUser, related_name='participants')
    description = models.TextField(max_length=500, null=True, blank=True)
    topic = models.CharField(max_length=100, null=True, blank=True)

    updated = models.DateTimeField(auto_now=True)
    timestamp = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-timestamp']

    @property
    def room_group_name(self):
        return f'chat_room_{self.id}'

    def __str__(self) -> str:
        return f'chat_room_{self.id}'

    


class Message(models.Model):
    chat_room = models.ForeignKey(
        ChatRoom, null=True, on_delete=models.CASCADE)
    host = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    description = models.TextField(max_length=500)

    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created']

    def __str__(self) -> str:
        return self.describe[0:50]
