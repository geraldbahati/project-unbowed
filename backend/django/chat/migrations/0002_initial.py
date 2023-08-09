# Generated by Django 4.2.3 on 2023-08-06 11:25

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('chat', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.AddField(
            model_name='message',
            name='sender',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='sent_messages', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='chatroom',
            name='admins',
            field=models.ManyToManyField(blank=True, related_name='admin_chatrooms', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='chatroom',
            name='creator',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='created_chatrooms', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='chatroom',
            name='participants',
            field=models.ManyToManyField(related_name='participating_chatrooms', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddIndex(
            model_name='message',
            index=models.Index(fields=['chat_room', 'created_at', 'updated', 'sender'], name='chat_messag_chat_ro_5c8ceb_idx'),
        ),
    ]
