import 'package:unbowed_flutter/data/models/register/confirm_message_model.dart';
import 'package:unbowed_flutter/data/models/register/otp_error_model.dart';
import 'package:unbowed_flutter/data/models/register/token_refresh_request_model.dart';
import 'package:unbowed_flutter/data/models/register/token_refresh_response_model.dart';

import '../config/config.dart';
import '../models/register/register_response_model.dart';
import '../models/register/send_otp_model.dart';
import '../models/register/verify_otp_model.dart';
import '../services/api_services.dart';

class UserRepository {
  static ApiService<String> submitPhoneNumber({
    required String phoneNumber,
  }) {
    final SendOtpModel sendOtpModel = SendOtpModel(
      phoneNumber: phoneNumber,
    );

    const String url = Config.sendNumberURL;

    return ApiService(
      url: url,
      body: sendOtpModelToJson(sendOtpModel),
      parse: (response) {
        ConfirmMessageModel message =
            confirmMessageModelFromJson(response.body);
        return message.sharedSecret;
      },
    );
  }

  static ApiService<Object> verifyOtp({
    required String phoneNumber,
    required String verificationCode,
    required String secretKey,
  }) {
    final VerifyOtpModel verifyOtpModel = VerifyOtpModel(
      phoneNumber: phoneNumber,
      verificationCode: verificationCode,
      secretKey: secretKey,
    );

    const String url = Config.verifyOtpURL;

    return ApiService(
      url: url,
      body: verifyOtpModelToJson(verifyOtpModel),
      parse: (response) {
        if (response.statusCode == 400) {
          return otpErrorModelFromJson(response.body);
        }
        return registerResponseModelFromJson(response.body);
      },
    );
  }

  static ApiService<TokenRefreshResponse> refreshAccessToken(
      {required String refreshToken}) {
    const String url = Config.refreshTokenURL;
    final TokenRefreshRequest refreshTokenRequest = TokenRefreshRequest(
      refresh: refreshToken,
    );

    return ApiService(
      url: url,
      body: tokenRefreshRequestToJson(refreshTokenRequest),
      parse: (response) {
        // TODO: Implement error handling
        return tokenRefreshResponseFromJson(response.body);
      },
    );
  }
}
