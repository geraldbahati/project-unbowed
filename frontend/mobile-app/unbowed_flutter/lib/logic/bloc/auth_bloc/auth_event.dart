// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthEventInitial extends AuthEvent {}

class SendPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;

  SendPhoneNumberEvent({required this.phoneNumber});
}

class VerifyOtpEvent extends AuthEvent {
  final String phoneNumber;
  final String verificationCode;

  VerifyOtpEvent({
    required this.phoneNumber,
    required this.verificationCode,
  });
}

class RefreshTokenEvent extends AuthEvent {}

class CheckIfUserTokenHasExpiredEvent extends AuthEvent {}
