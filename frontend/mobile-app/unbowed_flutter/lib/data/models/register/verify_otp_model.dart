// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) =>
    VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
  final String phoneNumber;
  final String verificationCode;
  final String secretKey;

  VerifyOtpModel({
    required this.phoneNumber,
    required this.verificationCode,
    required this.secretKey,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        phoneNumber: json["phone_number"],
        verificationCode: json["verification_code"],
        secretKey: json["secret_key"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "verification_code": verificationCode,
        "secret_key": secretKey,
      };
}
