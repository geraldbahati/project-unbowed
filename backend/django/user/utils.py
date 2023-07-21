from django.conf import settings
import africastalking
import pyotp

from .mobitech_service import MobiTech


# !!!!!!!!! TODO! Handle exceptions lateer

def send_otp_sms(phone_number, otp):
    # Send the OTP code via SMS using Twilio API or any other SMS provider
    # username = settings.AFRICASTALKING_USERNAME
    # api_key = settings.AFRICASTALKING_API_KEY
    # sender_id = settings.AFRICASTALKING_SMS_SENDER_ID

    # africastalking.initialize(username, api_key)
    # sms = africastalking.SMS

    # try:
    #     response = sms.send(f"Your ArtLife Production verification code is {otp}", [phone_number], sender_id)
    #     print(response)
    #     return True
    
    # except Exception as e:
    #     print(f"An error occurred while sending the OTP code: {e}")
    #     return False
   
    mobitech = MobiTech()
    response = mobitech.send_otp(phone_number, otp)

    return response[0]['status_desc'] == 'Success'

def generate_and_send_otp(phone_number):
    # Generate a TOTP object using a shared secret key
    shared_secret = pyotp.random_base32()
    totp = pyotp.TOTP(shared_secret, interval=120)

    # Generate the OTP code
    otp = totp.now()

    # Send the OTP via SMS
    if send_otp_sms(phone_number, otp):
        return shared_secret
    else:
        return None
    

def verify_otp(otp, shared_secret):
    # Create a TOTP object using the shared secret
    totp = pyotp.TOTP(shared_secret)

    # Verify the provided OTP against the TOTP
    return totp.verify(otp)