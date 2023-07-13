// To parse this JSON data, do
//
//     final chatRoomModel = chatRoomModelFromJson(jsonString);

import 'dart:convert';

List<ChatRoomModel> chatRoomModelFromJson(String str) =>
    List<ChatRoomModel>.from(json
        .decode(utf8.decode(str.runes.toList()))['results']
        .map((x) => ChatRoomModel.fromJson(x)));

String chatRoomModelToJson(List<ChatRoomModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatRoomModel {
  ChatRoomModel({
    required this.id,
    required this.courseChatroom,
    required this.owner,
    required this.participants,
    required this.lastMessage,
    required this.updated,
    required this.timestamp,
  });

  final int id;
  final CourseChatroom courseChatroom;
  final Owner owner;
  final List<int> participants;
  final String? lastMessage;
  final DateTime updated;
  final DateTime timestamp;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
        id: json["id"],
        courseChatroom: CourseChatroom.fromJson(json["course_chatroom"]),
        owner: Owner.fromJson(json["owner"]),
        participants: List<int>.from(json["participants"].map((x) => x)),
        lastMessage: json["last_message"],
        updated: DateTime.parse(json["updated"]),
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "course_chatroom": courseChatroom.toJson(),
        "owner": owner.toJson(),
        "participants": List<dynamic>.from(participants.map((x) => x)),
        "last_message": lastMessage == null ? null : lastMessage,
        "updated": updated.toIso8601String(),
        "timestamp": timestamp.toIso8601String(),
      };
}

class CourseChatroom {
  CourseChatroom({
    required this.courseName,
    required this.id,
  });

  final String courseName;
  final int id;

  factory CourseChatroom.fromJson(Map<String, dynamic> json) => CourseChatroom(
        courseName: json["course_name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "course_name": courseName,
        "id": id,
      };
}

class Owner {
  Owner({
    required this.username,
    required this.id,
  });

  final String username;
  final int id;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        username: json["username"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "id": id,
      };
}
