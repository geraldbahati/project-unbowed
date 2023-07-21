// To parse this JSON data, do
//
//     final confirmMessageModel = confirmMessageModelFromJson(jsonString);

import 'dart:convert';

ConfirmMessageModel confirmMessageModelFromJson(String str) =>
    ConfirmMessageModel.fromJson(json.decode(str));

String confirmMessageModelToJson(ConfirmMessageModel data) =>
    json.encode(data.toJson());

class ConfirmMessageModel {
  final String message;
  final String sharedSecret;

  ConfirmMessageModel({
    required this.message,
    required this.sharedSecret,
  });

  factory ConfirmMessageModel.fromJson(Map<String, dynamic> json) =>
      ConfirmMessageModel(
        message: json["message"],
        sharedSecret: json["shared_secret"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "shared_secret": sharedSecret,
      };
}
