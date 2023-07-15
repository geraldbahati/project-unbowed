import 'package:unbowed_flutter/data/models/register/login_request_model.dart';
import 'package:unbowed_flutter/data/models/register/register_exception_model.dart';
import 'package:unbowed_flutter/data/models/register/register_response_model.dart';
import 'package:unbowed_flutter/data/services/api_services.dart';
import 'package:unbowed_flutter/data/services/shared_services.dart';

import '../config/config.dart';
import '../models/register/register_request_model.dart';

class UserRepository {
  Api api = Api();

  static ApiService<Object> registerUser({
    required String username,
    required String phoneNumber,
    required String password,
  }) {
    final RegisterRequestModel registerRequestModel = RegisterRequestModel(
      username: username,
      phoneNumber: phoneNumber,
      password: password,
      password2: password,
    );

    const String url = "${Config.domain}${Config.registerURL}";

    return ApiService(
      url: url,
      body: registerRequestModelToJson(registerRequestModel),
      parse: (response) {
        if (response.statusCode == 400) {
          return registerExceptionModelFromJson(response.body);
        }
        return registerResponseModelFromJson(response.body);
      },
    );
  }

  static ApiService<RegisterResponseModel> loginUser({
    required String phoneNumber,
    required String password,
  }) {
    final LoginRequestModel loginModel = LoginRequestModel(
      phoneNumber: phoneNumber,
      password: password,
    );

    const String url = "${Config.domain}${Config.loginURL}";

    return ApiService(
      url: url,
      body: loginRequestModelToJson(loginModel),
      parse: (response) {
        var user = registerResponseModelFromJson(response.body);
        SharedService().setLoginDetails(user);
        return user;
      },
    );
  }
}
