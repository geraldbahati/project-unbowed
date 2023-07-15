// login exceptions

class UserNotFoundAuthException implements Exception {}

class WrongCredentialAuthException implements Exception {}

// register exceptions
class FailedToRegisterException implements Exception {}

class PhoneNumberAlreadyExistException implements Exception {}

class PasswordsDoNotMatchException implements Exception {}

class UsernameAlreadyExistException implements Exception {}

//generic exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
