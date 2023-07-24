// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int id;
  final String phoneNumber;
  final String username;
  final bool isStaff;

  User({
    required this.id,
    required this.phoneNumber,
    required this.username,
    required this.isStaff,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        phoneNumber: json["phone_number"],
        username: json["username"],
        isStaff: json["is_staff"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone_number": phoneNumber,
        "username": username,
        "is_staff": isStaff,
      };
}
