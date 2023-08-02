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

  VerifyOtpModel({
    required this.phoneNumber,
    required this.verificationCode,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
        phoneNumber: json["phone_number"],
        verificationCode: json["verification_code"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "verification_code": verificationCode,
      };
}
