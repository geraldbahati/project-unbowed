// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

List<Message> messageFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  final int id;
  final String messageUrl;
  final String editUrl;
  final Room room;
  final Sender sender;
  final String description;
  final DateTime updated;
  final DateTime created;

  Message({
    required this.id,
    required this.messageUrl,
    required this.editUrl,
    required this.room,
    required this.sender,
    required this.description,
    required this.updated,
    required this.created,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        messageUrl: json["message_url"],
        editUrl: json["edit_url"],
        room: Room.fromJson(json["room"]),
        sender: Sender.fromJson(json["sender"]),
        description: json["description"],
        updated: DateTime.parse(json["updated"]),
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message_url": messageUrl,
        "edit_url": editUrl,
        "room": room.toJson(),
        "sender": sender.toJson(),
        "description": description,
        "updated": updated.toIso8601String(),
        "created": created.toIso8601String(),
      };
}

class Room {
  final String? name;
  final Sender host;

  Room({
    required this.name,
    required this.host,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        name: json["name"],
        host: Sender.fromJson(json["host"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "host": host.toJson(),
      };
}

class Sender {
  final String phoneNumber;
  final String username;

  Sender({
    required this.phoneNumber,
    required this.username,
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
