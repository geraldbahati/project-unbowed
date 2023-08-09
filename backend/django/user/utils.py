from django.conf import settings
from django.core.cache import cache
import pyotp
import uuid

from .mobitech_service import MobiTech
import datetime


# !!!!!!!!! TODO! Handle exceptions lateer

def send_otp_sms(phone_number, otp):
    '''
    Send the OTP code via SMS
    '''
    mobitech = MobiTech()
    response = mobitech.send_otp(phone_number, otp)

    return response[0]['status_desc'] == 'Success'


def generate_and_send_otp(phone_number) -> bool:
    '''
    Generate an OTP code and send it to the user's phone number
    '''
    # Generate a TOTP object using a shared secret key
    shared_secret = pyotp.random_base32()
    totp = pyotp.TOTP(shared_secret, interval=300)

    # Generate the OTP code
    otp = totp.now()

    # Cache the shared_secret for this phone number
    cache.set(phone_number, shared_secret, 300)  # cache for 5 minutes

    # Send the OTP via SMS
    return send_otp_sms(phone_number, otp)
   

def verify_otp(phone_number, otp) -> bool:
    '''
    Verify the OTP code provided by the user
    '''
    # Retrieve the shared_secret from cache
    shared_secret = cache.get(phone_number)

    if shared_secret is None:
        return False

    # Create a TOTP object using the shared secret
    totp = pyotp.TOTP(shared_secret, interval=300)
    
    # Verify the provided OTP against the TOTP
    return totp.verify(otp)


def generate_session_id():
    '''
    Generate a unique session ID
    '''
    return str(uuid.uuid4())
    
    