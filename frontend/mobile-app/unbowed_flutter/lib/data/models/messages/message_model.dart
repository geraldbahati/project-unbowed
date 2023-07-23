// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) => List<Message>.from(json
    .decode(utf8.decode(str.runes.toList()))['results']
    .map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  final int? id;
  final String? messageUrl;
  final String? editUrl;
  final Room? room;
  final Sender? sender;
  final String? description;
  final DateTime? updated;
  final DateTime? created;
  bool isFirst = false;
  bool isMiddle = false;
  bool isLast = false;

  Message({
    this.id,
    this.messageUrl,
    this.editUrl,
    this.room,
    this.sender,
    this.description,
    this.updated,
    this.created,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        messageUrl: json["message_url"],
        editUrl: json["edit_url"],
        room: json["room"] == null ? null : Room.fromJson(json["room"]),
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        description: json["description"],
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message_url": messageUrl,
        "edit_url": editUrl,
        "room": room?.toJson(),
        "sender": sender?.toJson(),
        "description": description,
        "updated": updated?.toIso8601String(),
        "created": created?.toIso8601String(),
      };
}

class Room {
  final String? name;
  final Sender? host;

  Room({
    this.name,
    this.host,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        name: json["name"],
        host: json["host"] == null ? null : Sender.fromJson(json["host"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "host": host?.toJson(),
      };
}

class Sender {
  final String? phoneNumber;
  final String? username;

  Sender({
    this.phoneNumber,
    this.username,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        phoneNumber: json["phone_number"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "username": username,
      };
}
