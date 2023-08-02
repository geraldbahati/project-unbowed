// To parse this JSON data, do
//
//     final tokenRefreshResponse = tokenRefreshResponseFromJson(jsonString);

import 'dart:convert';

TokenRefreshResponse tokenRefreshResponseFromJson(String str) =>
    TokenRefreshResponse.fromJson(json.decode(str));

String tokenRefreshResponseToJson(TokenRefreshResponse data) =>
    json.encode(data.toJson());

class TokenRefreshResponse {
  final String access;

  TokenRefreshResponse({
    required this.access,
  });

  factory TokenRefreshResponse.fromJson(Map<String, dynamic> json) =>
      TokenRefreshResponse(
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "access": access,
      };
}
