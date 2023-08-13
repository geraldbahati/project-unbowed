from typing import Any
from django.db import models
from django.db.models import Q
from django.core.exceptions import ValidationError
from django.db.models.query import QuerySet

from .validators import validate_file_type
from .utils import get_upload_path
from user.models import CustomUser

# Create your models here.

class MessageManager(models.Manager):
    def get_queryset(self) -> QuerySet:
        return super().get_queryset().filter(deleted_at__isnull=True)


class ChatRoomManager(models.Manager):
    def create(self, **kwargs: Any) -> Any:
        creator = kwargs.get('creator')

        chatroom = super().create(**kwargs)

        if creator is not None:
            chatroom.admins.add(creator)

        return chatroom

    def get_chatroom_object(self, room_id):
        return self.get_queryset().filter(id=room_id).first() or None

    def get_or_new(self, host, other_users):
        pass


class ChatRoom(models.Model):
    ''' ChatRoom model, supporting direct and group chats '''
    DIRECT = 'direct'
    GROUP = 'group'

    CHAT_TYPE_CHOICES = [
        (DIRECT, 'Direct'),
        (GROUP, 'Group'),
    ]

    chat_type = models.CharField(
        max_length=7,
        choices=CHAT_TYPE_CHOICES,
        default=DIRECT
    )

    creator = models.ForeignKey(
        CustomUser,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='created_chatrooms'
    )

    admins = models.ManyToManyField(
        CustomUser,
        related_name='admin_chatrooms',
        blank=True
    )

    participants = models.ManyToManyField(
        CustomUser,
        related_name='participating_chatrooms'
    )

    name = models.CharField(max_length=100, null=True, blank=True)
    description = models.TextField(max_length=500, null=True, blank=True)
    topic = models.CharField(max_length=100, null=True, blank=True)

    last_message_read_time = models.DateTimeField(null=True, blank=True)
    updated = models.DateTimeField(auto_now=True)
    created_at = models.DateTimeField(auto_now_add=True)

    objects = ChatRoomManager()

    class Meta:
        ordering = ['-created_at']

    @property
    def room_group_name(self):
        return f'chat_room_{self.id}'

    def is_direct(self):
        return self.chat_type == self.DIRECT

    def is_group(self):
        return self.chat_type == self.GROUP

    def is_admin(self, user):
        return user in self.admins.all()

    def save(self, *args, **kwargs):
        # If creating a new instance, save it first to generate an id.
        if not self.id:
            super(ChatRoom, self).save(*args, **kwargs)

        # Now you can check participants count safely.
        if self.is_direct() and self.participants.count() != 2:
            raise ValidationError(
                "Direct chats must have exactly two participants.")

        super(ChatRoom, self).save(*args, **kwargs)

    def save(self, *args, **kwargs):
        self.clean()
        super(ChatRoom, self).save(*args, **kwargs)

    def __str__(self) -> str:
        return self.name or f'chat_room_{self.id}'


class Message(models.Model):
    ''' Message model, supporting text, audio, and image messages '''
    TEXT = 'text'
    AUDIO = 'audio'
    IMAGE = 'image'
    VIDEO = 'video'
    DOCUMENT = 'document'

    SENT = 'sent'
    DELIVERED = 'delivered'
    READ = 'read'

    FILE_TYPE_CHOICES = [
        (TEXT, 'Text'),
        (AUDIO, 'Audio'),
        (IMAGE, 'Image'),
        (VIDEO, 'Video'),
        (DOCUMENT, 'Document'),
        # more types to be added later
    ]

    STATUS_CHOICES = [
        (SENT, 'Sent'),
        (DELIVERED, 'Delivered'),
        (READ, 'Read'),
    ]

    chat_room = models.ForeignKey(
        ChatRoom, on_delete=models.CASCADE,
        null=True
    )

    sender = models.ForeignKey(
        CustomUser,
        on_delete=models.CASCADE,
        related_name="sent_messages"
    )

    message_type = models.CharField(
        max_length=10,
        choices=FILE_TYPE_CHOICES,
        default=TEXT
    )

    text_content = models.TextField(
        max_length=500,
        null=True, blank=True,
        help_text="Text content for text messages"
    )

    file = models.FileField(
        upload_to=get_upload_path,
        null=True, blank=True,
        validators=[validate_file_type],
        help_text="File content for audio, image, video, and document messages"
    )

    status = models.CharField(
        max_length=10, choices=STATUS_CHOICES, default=SENT)
    reply_to = models.ForeignKey(
        'self', on_delete=models.SET_NULL, null=True, blank=True)
    read = models.BooleanField(default=False)  # for read receipts

    # for flagging/reporting messages
    flagged = models.BooleanField(default=False)

    # for storing additional metadata
    metadata = models.JSONField(null=True, blank=True)
    deleted_at = models.DateTimeField(
        null=True, blank=True)  # for soft-deleting messages

    updated = models.DateTimeField(auto_now=True)
    created_at = models.DateTimeField(auto_now_add=True)

    objects = MessageManager()
    # If you still want to access all messages including deleted ones
    all_objects = models.Manager()

    class Meta:
        ordering = ['-created_at']
        indexes = [
            models.Index(
                fields=['chat_room', 'created_at', 'updated', 'sender']),
        ]

    def __str__(self) -> str:
        if self.message_type == self.TEXT:
            return self.text_content[0:50]
        elif self.message_type == self.AUDIO:
            return f"Audio from {self.sender.username}"
        elif self.message_type == self.IMAGE:
            return f"Image from {self.sender.username}"
        elif self.message_type == self.VIDEO:
            return f"Video from {self.sender.username}"
        elif self.message_type == self.DOCUMENT:
            return f"Document from {self.sender.username}"

    def clean(self):
        """Ensure that the correct fields are populated based on message_type."""
        if self.message_type == self.TEXT:
            if self.file:
                raise ValidationError(
                    "Text messages cannot have a file attached.")
            if not self.text_content:
                raise ValidationError(
                    "Text messages must have text content.")
        else:
            if not self.file:
                raise ValidationError(
                    "Audio, image, video, and document messages must have a file attached.")
            if self.text_content:
                raise ValidationError(
                    "Audio, image, video, and document messages cannot have text content.")

    def save(self, *args, **kwargs):
        self.clean()
        super(Message, self).save(*args, **kwargs)
