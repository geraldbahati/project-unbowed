// register exceptions
class OtpErrorException implements Exception {}

class InvalidOtpException implements Exception {}

class InvalidPhoneNumberException implements Exception {}

class PhoneNumberAlreadyExistException implements Exception {}

class PasswordsDoNotMatchException implements Exception {}

class UserNotRegisteredException implements Exception {}

//generic exceptions

class GenericAuthException implements Exception {}

class FailedToSubmitPhoneNumberException implements Exception {}
