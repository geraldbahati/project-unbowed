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

class AuthLoggingOut extends AuthState {
  final Exception? exception;
  final bool isLoading;
  AuthLoggingOut({
    required this.exception,
    required this.isLoading,
  });
}
