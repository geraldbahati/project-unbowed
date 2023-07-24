// To parse this JSON data, do
//
//     final otpErrorModel = otpErrorModelFromJson(jsonString);

import 'dart:convert';

OtpErrorModel otpErrorModelFromJson(String str) =>
    OtpErrorModel.fromJson(json.decode(str));

String otpErrorModelToJson(OtpErrorModel data) => json.encode(data.toJson());

class OtpErrorModel {
  final List<String>? phoneNumber;
  final List<String>? verificationCode;

  OtpErrorModel({
    this.phoneNumber,
    this.verificationCode,
  });

  factory OtpErrorModel.fromJson(Map<String, dynamic> json) => OtpErrorModel(
        phoneNumber: json["phone_number"] == null
            ? []
            : List<String>.from(json["phone_number"]!.map((x) => x)),
        verificationCode: json["verification_code"] == null
            ? []
            : List<String>.from(json["verification_code"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber == null
            ? []
            : List<dynamic>.from(phoneNumber!.map((x) => x)),
        "verification_code": verificationCode == null
            ? []
            : List<dynamic>.from(verificationCode!.map((x) => x)),
      };
}
