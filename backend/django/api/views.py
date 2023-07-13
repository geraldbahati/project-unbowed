from django.shortcuts import render
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView
from rest_framework.response import Response

class MyProtectedView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, format=None):
        content = {'message': 'Hello, authenticated user!'}
        return Response(content)
