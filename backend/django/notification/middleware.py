from urllib import parse
from channels.db import database_sync_to_async
from channels.auth import AuthMiddlewareStack
from django.contrib.auth.models import AnonymousUser
from django.db import close_old_connections
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework_simplejwt.exceptions import InvalidToken, TokenError
from rest_framework_simplejwt.tokens import UntypedToken
from rest_framework.exceptions import AuthenticationFailed


@database_sync_to_async
def get_user_from_headers_or_queries(scope):
    """
    Function to get the `User` object
    from the headers or queries.
    :return User object or None
    """
    try:
        headers = dict(scope["headers"])
    except KeyError:
        headers = {}

    try:
        params = dict(parse.parse_qsl(scope["query_string"].decode("utf8")))
    except KeyError:
        params = {}

    token_key = None
    token_is_found = False

    if b"authorization" in headers:
        # Get token from authorization headers
        token_name, token_key = headers[b"authorization"].decode().split()
        if token_name.lower() == "bearer":
            token_is_found = True

    if not token_is_found:
        # Get token from query parameters
        token_key = params.get("token")
        token_is_found = bool(token_key)

    if token_is_found:
        try:
            # Authenticate the token
            validated_token = JWTAuthentication().get_validated_token(token_key)
            user = JWTAuthentication().get_user(validated_token)
            close_old_connections()
            return user
        except (InvalidToken, TokenError, AuthenticationFailed):
            # Token is invalid or authentication failed
            scope['user'] = AnonymousUser()

    return None


class TokenAuthMiddleware:

    def __init__(self, app):
        # Store the ASGI application we were passed
        self.app = app

    async def __call__(self, scope, receive, send):
        user = await get_user_from_headers_or_queries(scope)
        if user is not None:
            scope["user"] = user
        return await self.app(scope, receive, send)


def TokenAuthMiddlewareStack(inner):
    """
    Middleware to support WebSocket SSH connection
    using token authentication.
    """
    return TokenAuthMiddleware(AuthMiddlewareStack(inner))
