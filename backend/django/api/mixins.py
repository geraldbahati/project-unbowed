from rest_framework import permissions
from .permissions import IsStaffEditorPermission, IsOwnerOrReadOnly

class StaffEditorPermissionMixin():
    permission_classes = [permissions.IsAdminUser ,IsStaffEditorPermission]

class OwnerOrReadOnlyPermissionMixin():
    permission_classes = [IsOwnerOrReadOnly]

class AuthorisedPermissionMixin():
    permission_classes = [
        permissions.IsAuthenticated,
    ]