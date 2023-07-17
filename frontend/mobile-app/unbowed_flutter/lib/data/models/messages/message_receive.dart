// To parse this JSON data, do
//
//     final msReceive = msReceiveFromJson(jsonString);

import 'dart:convert';

MessageReceive msReceiveFromJson(String str) =>
    MessageReceive.fromJson(json.decode(utf8.decode(str.runes.toList())));

String msReceiveToJson(MessageReceive data) => json.encode(data.toJson());

class MessageReceive {
  MessageReceive({
    required this.message,
    required this.username,
    required this.created,
  });

  final String message;
  final String username;
  final DateTime created;

  factory MessageReceive.fromJson(Map<String, dynamic> json) => MessageReceive(
        message: json["message"],
        username: json["username"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "username": username,
        "created": created.toIso8601String(),
      };
}
