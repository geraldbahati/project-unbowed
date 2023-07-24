// To parse this JSON data, do
//
//     final messageRequest = messageRequestFromJson(jsonString);

import 'dart:convert';

MessageRequest messageRequestFromJson(String str) =>
    MessageRequest.fromJson(json.decode(str));

String messageRequestToJson(MessageRequest data) => json.encode(data.toJson());

class MessageRequest {
  final String action;
  final String message;

  MessageRequest({
    required this.action,
    required this.message,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) => MessageRequest(
        action: json["action"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "message": message,
      };
}
