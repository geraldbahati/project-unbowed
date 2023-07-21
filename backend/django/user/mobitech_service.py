import requests
import json
from django.conf import settings
import pyotp

class MobiTech:    
    def send_otp(self, mobile_number, otp):
        url = "https://api.mobitechtechnologies.com/sms/sendsms"
        headers = {
            "Content-Type": "application/json",
            "h_api_key": settings.MOBITECH_API_KEY
        }
        
        data = {
            "mobile": mobile_number,
            "response_type": "json",
            "sender_name": "23107",
            "service_id": 0,
            "message": f"Your ArtLife Production verification code is {otp}"
        }
        response = requests.post(url, headers=headers, data=json.dumps(data))
        print(response.json())
        return response.json()
