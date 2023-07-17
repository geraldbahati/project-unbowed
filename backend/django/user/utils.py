
from twilio.rest import Client
from django.conf import settings

def send_otp_sms(phone_number, otp):
    """
    Send the OTP code via SMS using Twilio API or any other SMS provider
    """
    # Send the OTP code via SMS using Twilio API or any other SMS provider
    client = Client(settings.TWILIO_ACCOUNT_SID, settings.TWILIO_AUTH_TOKEN)

    verification = client.verify.v2.services(settings.TWILIO_VERIFY_SID).verifications.create(to=phone_number, channel="sms")

    return verification.status == 'pending'


def verify_otp(phone_number, otp, shared_secret):
    """
    Verify the OTP code
    """
    # Verify the OTP code
    client = Client(settings.TWILIO_ACCOUNT_SID, settings.TWILIO_AUTH_TOKEN)

    verification_check = client.verify.v2.services(settings.TWILIO_VERIFY_SID).verification_checks.create(to=phone_number, code=otp)

    if verification_check.status == 'approved':
        return verification_check.sid
    
    return None