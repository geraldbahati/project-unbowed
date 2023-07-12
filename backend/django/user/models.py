from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin

from django.dispatch import receiver
from django.db.models.signals import (
    pre_save,
    post_save,
)


class UserManager(BaseUserManager):
    def create_user(self, username, phone_number, password=None, is_admin=False, is_active=True):
        """
        Creates and saves a User with the given email, date of
        birth and password.
        """
        if not username:
            raise ValueError('Users must have a username')

        user = self.model(
            username=username,
            phone_number=phone_number,
            is_admin=is_admin,
            is_active=is_active,
        )

        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, username, phone_number, password=None):
        """
        Creates and saves a superuser with the given email, date of
        birth and password.
        """
        user = self.create_user(
            phone_number=phone_number,
            password=password,
            username=username,
        )
        user.is_superuser = True
        user.is_admin = True
        user.save(using=self._db)
        return user

# Create your models here.


class CustomUser(AbstractBaseUser, PermissionsMixin):
    username = models.CharField(unique=True, max_length=255)
    phone_number = models.CharField(max_length=15 )

    is_admin = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    USERNAME_FIELD = 'username'
    REQUIRED_FIELDS = ['phone_number']

    objects = UserManager()

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        "Does the user have a specific permission?"
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        "Does the user have permissions to view the app `app_label`?"
        # Simplest possible answer: Yes, always
        return True

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        # Simplest possible answer: All admins are staff
        return self.is_admin


# @receiver(pre_save, sender=User)
# def user_pre_save(sender, instance, *args, **kwargs):
#     if not instance.course_name:
#         instance.course_name = Course.objects.get(
#             course_name='computerscience')


# @receiver(post_save, sender=User)
# def user_post_save(sender, instance, created, *args, **kwargs):
#     print(instance.course_name)
#     chat_room_instances = instance.course_name.chatroom_set.all() or None

#     if chat_room_instances is not None:
#         for chatroom in chat_room_instances:
#             if chatroom.host != instance:
#                 chatroom.participants.add(instance)
