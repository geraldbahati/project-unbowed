// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthRegistering extends AuthState with EquatableMixin {
  final Exception? exception;
  final bool isLoading;
  AuthRegistering({
    required this.exception,
    required this.isLoading,
  });

  @override
  List<Object?> get props => [exception, isLoading];
}

class AuthRegistered extends AuthState {
  final RegisterResponseModel user;

  AuthRegistered({
    required this.user,
  });
}

class AuthUnregistered extends AuthState {}

class AuthPhoneNumberSent extends AuthState {
  final String phoneNumber;
  final String secretKey;

  AuthPhoneNumberSent({
    required this.phoneNumber,
    required this.secretKey,
  });
}

class RefreshingAccessToken extends AuthState {
  final bool isLoading;

  RefreshingAccessToken({
    required this.isLoading,
  });
}

class AccessTokenRefreshed extends AuthState {
  final bool isAccessTokenRefreshed;

  AccessTokenRefreshed({
    required this.isAccessTokenRefreshed,
  });
}

class CheckingAccessToken extends AuthState {
  final bool isLoading;

  CheckingAccessToken({
    required this.isLoading,
  });
}
