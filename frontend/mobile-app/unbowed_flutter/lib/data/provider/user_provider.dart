import 'package:unbowed_flutter/data/exceptions/auth_exceptions.dart';

import '../models/register/register_exception_model.dart';
import '../models/register/register_response_model.dart';
import '../repositories/user_repository.dart';
import '../services/api_services.dart';
import '../services/shared_services.dart';

abstract class UserProvider {
  Future<RegisterResponseModel?> get currentUser;
  Future<RegisterResponseModel> registerUser({
    required String username,
    required String phoneNumber,
    required String password,
  });

  Future<RegisterResponseModel> loginUser({
    required String phoneNumber,
    required String password,
  });

  Future<void> logoutUser();
}

class UserService implements UserProvider {
  UserService();

  @override
  Future<RegisterResponseModel?> get currentUser async {
    var user = await SharedService().getLoginDetails();
    return user;
  }

  @override
  Future<RegisterResponseModel> loginUser({
    required String phoneNumber,
    required String password,
  }) async {
    var loginDetails = UserRepository.loginUser(
      phoneNumber: phoneNumber,
      password: password,
    );

    final RegisterResponseModel userDetail = await Api().post(loginDetails);
    SharedService().logout();
    SharedService().setLoginDetails(userDetail);

    return userDetail;
  }

  @override
  Future<void> logoutUser() {
    // TODO: implement logoutUser
    throw UnimplementedError();
  }

  @override
  Future<RegisterResponseModel> registerUser(
      {required String username,
      required String phoneNumber,
      required String password}) async {
    var registerDetails = UserRepository.registerUser(
      username: username,
      phoneNumber: phoneNumber,
      password: password,
    );
    var userDetail = await Api().post(registerDetails);
    try {
      if (userDetail is RegisterExceptionModel) {
        throw FailedToRegisterException();
      }

      if (userDetail is RegisterResponseModel) {
        SharedService().logout();
        SharedService().setLoginDetails(userDetail);
        return userDetail;
      }

      throw UserNotLoggedInAuthException();
    } on FailedToRegisterException {
      if (userDetail is RegisterExceptionModel) {
        if (userDetail.username != null) {
          throw UsernameAlreadyExistException();
        }

        if (userDetail.phoneNumber != null) {
          throw PhoneNumberAlreadyExistException();
        }

        if (userDetail.password != null) {
          throw PasswordsDoNotMatchException();
        }
      }

      throw GenericAuthException();
    }
  }
}
