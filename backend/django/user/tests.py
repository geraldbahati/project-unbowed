from django.test import TestCase
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APIClient
from django.contrib.auth import get_user_model
from rest_framework_simplejwt.tokens import AccessToken


class AuthenticationTestCase(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.signup_url = reverse('signup')
        self.login_url = reverse('login')
        self.logout_url = reverse('logout')

    def test_signup(self):
        data = {
            'username': 'testuser',
            'password': 'testpassword',
            'phone_number': '1234567890',
            'password2': 'testpassword',
        }
        response = self.client.post(self.signup_url, data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('refresh', response.data)
        self.assertIn('access', response.data)

    def test_login(self):
        User = get_user_model()
        user = User.objects.create_user(
            username='testuser',
            password='testpassword',
            phone_number='1234567890'
        )
        data = {
            'phone_number': '1234567890',
            'password': 'testpassword'
        }
        response = self.client.post(self.login_url, data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('refresh', response.data)
        self.assertIn('access', response.data)


    def test_logout(self):
        User = get_user_model()
        user = User.objects.create_user(
            username='testuser',
            password='testpassword',
            phone_number='1234567890'
        )
        access_token = AccessToken.for_user(user)
        self.client.credentials(HTTP_AUTHORIZATION=f'Bearer {access_token}')
        response = self.client.post(self.logout_url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data, {'detail': 'Successfully logged out.'})
