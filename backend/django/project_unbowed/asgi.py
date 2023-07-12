"""
ASGI config for project_unbowed project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.0/howto/deployment/asgi/
"""

import os
import django

from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
from django.core.asgi import get_asgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'project_unbowed.settings')
django.setup()



application = ProtocolTypeRouter(
    {
        'http' : get_asgi_application(),
        # 'websocket': TokenAuthMiddlewareStack (
        #     URLRouter(
        #         websocket_urlpatterns
        #     )
        # ) 
    }
)
