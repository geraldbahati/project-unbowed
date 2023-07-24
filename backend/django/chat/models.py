from django.db import models
from django.db.models import Q

from user.models import CustomUser

# Create your models here.

class ChatRoomManager(models.Manager):
    def get_chatroom_object(self, room_id):
        return self.get_queryset().filter(id=room_id).first() or None
    
    def get_or_new(self, host, other_users):
        if host == other_users.first():
            return None, False

        if other_users is None:
            return None, False

        if host == other_users:
            return None, False

        qlookup1 = Q(host=host) & Q(participants__in=other_users)
        qlookup2 = Q(host=other_users.first()) & Q(
            participants=host) 
        qs = self.get_queryset().filter(qlookup1 | qlookup2).distinct()

        if qs.count() == 1:
            return qs.first(), False
        elif qs.count() > 1:
            return qs.order_by('timestamp').first(), False
        else:
            obj = self.model(
                host=host,
            )

            obj.save()
            obj.participants.set(other_users)
            return obj, True



class ChatRoom(models.Model):
    host = models.ForeignKey(
        CustomUser, on_delete=models.CASCADE, related_name='host')
    participants = models.ManyToManyField(CustomUser, related_name='participants')
    name = models.CharField(max_length=100, null=True, blank=True)
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
            ChatRoom, on_delete=models.CASCADE,
            null=True
        )
    host = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    description = models.TextField(max_length=500)

    updated = models.DateTimeField(auto_now=True)
    created = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created']

    def __str__(self) -> str:
        return self.description[0:50]
