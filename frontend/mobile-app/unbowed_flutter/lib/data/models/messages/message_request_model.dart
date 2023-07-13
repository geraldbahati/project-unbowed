/// To parse this JSON data, do
import 'dart:convert';

MessageRequest messageRequestFromJson(String str) =>
    MessageRequest.fromJson(json.decode(utf8.decode(str.runes.toList())));

String messageRequestToJson(MessageRequest data) => json.encode(data.toJson());

class MessageRequest {
  MessageRequest({
    required this.message,
  });

  final String message;

  factory MessageRequest.fromJson(Map<String, dynamic> json) => MessageRequest(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
