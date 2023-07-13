// To parse this JSON data, do
//
//     final msReceive = msReceiveFromJson(jsonString);

import 'dart:convert';

MsReceive msReceiveFromJson(String str) =>
    MsReceive.fromJson(json.decode(utf8.decode(str.runes.toList())));

String msReceiveToJson(MsReceive data) => json.encode(data.toJson());

class MsReceive {
  MsReceive({
    required this.message,
    required this.username,
    required this.created,
  });

  final String message;
  final String username;
  final DateTime created;

  factory MsReceive.fromJson(Map<String, dynamic> json) => MsReceive(
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
