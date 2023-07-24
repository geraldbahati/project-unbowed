// To parse this JSON data, do
//
//     final registerRequestModel = registerRequestModelFromJson(jsonString);

import 'dart:convert';

RegisterRequestModel registerRequestModelFromJson(String str) =>
    RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) =>
    json.encode(data.toJson());

class RegisterRequestModel {
  final String username;
  final String phoneNumber;
  final String password;
  final String password2;

  RegisterRequestModel({
    required this.username,
    required this.phoneNumber,
    required this.password,
    required this.password2,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        username: json["username"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        password2: json["password2"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "phone_number": phoneNumber,
        "password": password,
        "password2": password2,
      };
}
