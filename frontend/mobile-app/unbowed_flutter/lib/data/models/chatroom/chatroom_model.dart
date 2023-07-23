// To parse this JSON data, do
//
//     final chatroomModel = chatroomModelFromJson(jsonString);

import 'dart:convert';

List<ChatroomModel> chatroomModelFromJson(String str) =>
    List<ChatroomModel>.from(json
        .decode(utf8.decode(str.runes.toList()))['results']
        .map((x) => ChatroomModel.fromJson(x)));

String chatroomModelToJson(List<ChatroomModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatroomModel {
  final int id;
  final Owner owner;
  final List<String> participants;
  final String name;
  final String description;
  final String? lastMessage;
  final DateTime updated;
  final DateTime timestamp;

  ChatroomModel({
    required this.id,
    required this.owner,
    required this.participants,
    required this.name,
    required this.description,
    this.lastMessage,
    required this.updated,
    required this.timestamp,
  });

  factory ChatroomModel.fromJson(Map<String, dynamic> json) => ChatroomModel(
        id: json["id"],
        owner: Owner.fromJson(json["owner"]),
        participants: List<String>.from(json["participants"].map((x) => x)),
        name: json["name"],
        description: json["description"],
        lastMessage: json["last_message"],
        updated: DateTime.parse(json["updated"]),
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner": owner.toJson(),
        "participants": List<dynamic>.from(participants.map((x) => x)),
        "name": name,
        "description": description,
        "last_message": lastMessage,
        "updated": updated.toIso8601String(),
        "timestamp": timestamp.toIso8601String(),
      };
}

class Owner {
  final String phoneNumber;
  final String username;

  Owner({
    required this.phoneNumber,
    required this.username,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        phoneNumber: json["phone_number"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "username": username,
      };
}
