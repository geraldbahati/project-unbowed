import '../exceptions/auth_exceptions.dart';
import '../models/register/otp_error_model.dart';
import '../models/register/register_response_model.dart';
import '../repositories/user_repository.dart';
import '../services/api_services.dart';
import '../services/shared_services.dart';

abstract class UserProvider {
  Future<RegisterResponseModel?> get currentUser;
  Future<String> submitPhoneNumber({
    required String phoneNumber,
  });

  Future<RegisterResponseModel> verifyOtp({
    required String phoneNumber,
    required String verificationCode,
    required String secretKey,
  });
}

class UserService implements UserProvider {
  UserService();

  @override
  Future<RegisterResponseModel?> get currentUser async {
    var user = await SharedService().getLoginDetails();
    return user;
  }

  @override
  Future<String> submitPhoneNumber({required String phoneNumber}) async {
    var registerDetails = UserRepository.submitPhoneNumber(
      phoneNumber: phoneNumber,
    );

    try {
      var sharedSecret = await Api().postWithoutToken(registerDetails);
      return sharedSecret;
    } on Exception catch (_) {
      throw FailedToSubmitPhoneNumberException();
    }
  }

  @override
  Future<RegisterResponseModel> verifyOtp({
    required String phoneNumber,
    required String verificationCode,
    required String secretKey,
  }) async {
    var registerDetails = UserRepository.verifyOtp(
      phoneNumber: phoneNumber,
      verificationCode: verificationCode,
      secretKey: secretKey,
    );

    var userDetail = await Api().postWithoutToken(registerDetails);

    try {
      if (userDetail is OtpErrorModel) {
        throw OtpErrorException();
      }

      if (userDetail is RegisterResponseModel) {
        SharedService().logout();
        SharedService().setLoginDetails(userDetail);
        return userDetail;
      }

      throw UserNotRegisteredException();
    } on OtpErrorException {
      if (userDetail is OtpErrorModel) {
        if (userDetail.verificationCode != null) {
          throw InvalidOtpException();
        }

        if (userDetail.phoneNumber != null) {
          throw InvalidPhoneNumberException();
        }
      }

      throw GenericAuthException();
    }
  }
}
