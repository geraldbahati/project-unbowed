// To parse this JSON data, do
//
//     final message2 = message2FromJson(jsonString);
import 'dart:convert';

List<Message> messageFromJson(String str) => List<Message>.from(json
    .decode(utf8.decode(str.runes.toList()))['results']
    .map((x) => Message.fromJson(x)));

// String messageToJson(List<Message> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    this.id,
    this.messageUrl,
    this.editUrl,
    required this.host,
    this.topic,
    required this.describe,
    this.updated,
    this.created,
  });

  final int? id;
  final String? messageUrl;
  final String? editUrl;
  final Host host;
  final String? topic;
  final String describe;
  final DateTime? updated;
  final DateTime? created;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        messageUrl: json["message_url"],
        editUrl: json["edit_url"],
        host: Host.fromJson(json["sender"]),
        topic: json["topic"],
        describe: json["describe"],
        updated: DateTime.parse(json["updated"]),
        created: DateTime.parse(json["created"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "host": host.toJson(),
  //       "topic": topic,
  //       "describe": describe,
  //     };

  Map<String, dynamic> toJson() => {
        "host": host,
        "topic": topic,
        "describe": describe,
        "updated": updated?.toIso8601String(),
        "created": created?.toIso8601String(),
      };
}

class Host {
  Host({
    required this.username,
    required this.id,
  });

  final String username;
  final int id;

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        username: json["username"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "id": id,
      };
}
