import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../data/models/register/register_response_model.dart';
import '../../../../data/provider/user_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(UserProvider provider) : super(AuthInitial()) {
    on<AuthEventRegister>(
      (event, emit) async {
        // TODO: implement event handler

        emit(AuthRegistering(
          exception: null,
          isLoading: true,
        ));

        try {
          final RegisterResponseModel user = await provider.registerUser(
            username: event.username,
            phoneNumber: event.phoneNumber,
            password: event.password,
          );
          emit(AuthRegistering(
            exception: null,
            isLoading: false,
          ));
          emit(AuthRegistered(user: user));
        } on Exception catch (e) {
          emit(AuthRegistering(
            exception: e,
            isLoading: false,
          ));
        }
      },
    );
  }
}
