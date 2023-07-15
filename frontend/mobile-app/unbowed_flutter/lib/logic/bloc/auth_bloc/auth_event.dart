part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthEventRegister extends AuthEvent {
  final String username;
  final String phoneNumber;
  final String password;
  final String confirmPassword;

  AuthEventRegister({
    required this.username,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}

class AuthEventLogin extends AuthEvent {
  final String username;
  final String phoneNumber;
  final String password;

  AuthEventLogin({
    required this.username,
    required this.phoneNumber,
    required this.password,
  });
}

class AuthEventLogout extends AuthEvent {}

class AuthEventCheckLogin extends AuthEvent {}
