// To parse this JSON data, do
//
//     final registerExceptionModel = registerExceptionModelFromJson(jsonString);

import 'dart:convert';

RegisterExceptionModel registerExceptionModelFromJson(String str) =>
    RegisterExceptionModel.fromJson(json.decode(str));

String registerExceptionModelToJson(RegisterExceptionModel data) =>
    json.encode(data.toJson());

class RegisterExceptionModel {
  final List<String>? username;
  final List<String>? phoneNumber;
  final List<String>? password;

  RegisterExceptionModel({
    this.username,
    this.phoneNumber,
    this.password,
  });

  factory RegisterExceptionModel.fromJson(Map<String, dynamic> json) =>
      RegisterExceptionModel(
        username: json["username"] == null
            ? []
            : List<String>.from(json["username"]!.map((x) => x)),
        phoneNumber: json["phone_number"] == null
            ? []
            : List<String>.from(json["phone_number"]!.map((x) => x)),
        password: json["password"] == null
            ? []
            : List<String>.from(json["password"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username":
            username == null ? [] : List<dynamic>.from(username!.map((x) => x)),
        "phone_number": phoneNumber == null
            ? []
            : List<dynamic>.from(phoneNumber!.map((x) => x)),
        "password":
            password == null ? [] : List<dynamic>.from(password!.map((x) => x)),
      };
}
