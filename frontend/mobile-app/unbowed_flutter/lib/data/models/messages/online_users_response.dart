// To parse this JSON data, do
//
//     final onlineUsersResponse = onlineUsersResponseFromJson(jsonString);

import 'dart:convert';

OnlineUsersResponse onlineUsersResponseFromJson(String str) =>
    OnlineUsersResponse.fromJson(json.decode(str));

String onlineUsersResponseToJson(OnlineUsersResponse data) =>
    json.encode(data.toJson());

class OnlineUsersResponse {
  final String action;
  final List<String> users;

  OnlineUsersResponse({
    required this.action,
    required this.users,
  });

  factory OnlineUsersResponse.fromJson(Map<String, dynamic> json) =>
      OnlineUsersResponse(
        action: json["action"],
        users: List<String>.from(json["users"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "users": List<dynamic>.from(users.map((x) => x)),
      };
}
