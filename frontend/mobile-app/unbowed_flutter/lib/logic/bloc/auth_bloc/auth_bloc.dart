import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/register/register_response_model.dart';
import '../../../../data/provider/user_provider.dart';
import '../../../data/exceptions/auth_exceptions.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(UserProvider provider) : super(AuthInitial()) {
    on<SendPhoneNumberEvent>(
      (event, emit) async {
        emit(AuthRegistering(
          exception: null,
          isLoading: true,
        ));

        try {
          await provider.submitPhoneNumber(phoneNumber: event.phoneNumber);

          emit(AuthRegistering(
            exception: null,
            isLoading: false,
          ));

          emit(AuthPhoneNumberSent(
            phoneNumber: event.phoneNumber,
          ));
        } on FailedToSubmitPhoneNumberException catch (e) {
          emit(AuthRegistering(
            exception: e,
            isLoading: false,
          ));
        }
      },
    );

    on<VerifyOtpEvent>(
      (event, emit) async {
        emit(AuthRegistering(
          exception: null,
          isLoading: true,
        ));

        try {
          var user = await provider.verifyOtp(
            phoneNumber: event.phoneNumber,
            verificationCode: event.verificationCode,
          );

          emit(AuthRegistering(
            exception: null,
            isLoading: false,
          ));

          emit(AuthRegistered(
            user: user,
          ));
        } on Exception catch (e) {
          emit(AuthRegistering(
            exception: e,
            isLoading: false,
          ));
        }
      },
    );

    on<AuthEventInitial>(
      (event, emit) async {
        final user = await provider.currentUser;

        if (user != null) {
          emit(AuthRegistered(
            user: user,
          ));
        } else {
          emit(AuthUnregistered());
        }
      },
    );

    on<RefreshTokenEvent>(
      (event, emit) async {
        emit(RefreshingAccessToken(
          isLoading: true,
        ));

        try {
          bool isRefreshed = await provider.refreshAccessToken();

          emit(RefreshingAccessToken(
            isLoading: false,
          ));
          emit(AccessTokenRefreshed(isAccessTokenRefreshed: isRefreshed));
        } on Exception {
          emit(RefreshingAccessToken(
            isLoading: false,
          ));
        }
      },
    );

    on<CheckIfUserTokenHasExpiredEvent>(
      (event, emit) async {
        emit(CheckingAccessToken(
          isLoading: true,
        ));
        try {
          await provider.hasTokenExpired();

          emit(CheckingAccessToken(
            isLoading: false,
          ));
        } on UserTokenExpiredException {
          add(RefreshTokenEvent());
        }
      },
    );
  }
}
