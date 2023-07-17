# Generated by Django 4.2.3 on 2023-07-17 19:08

from django.db import migrations, models
import uuid


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0002_customuser_access_token_customuser_refresh_token'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='uid',
            field=models.UUIDField(blank=True, default=uuid.uuid4, editable=False, null=True),
        ),
    ]