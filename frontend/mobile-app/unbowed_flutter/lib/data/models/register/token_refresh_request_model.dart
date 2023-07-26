// To parse this JSON data, do
//
//     final tokenRefreshRequest = tokenRefreshRequestFromJson(jsonString);

import 'dart:convert';

TokenRefreshRequest tokenRefreshRequestFromJson(String str) =>
    TokenRefreshRequest.fromJson(json.decode(str));

String tokenRefreshRequestToJson(TokenRefreshRequest data) =>
    json.encode(data.toJson());

class TokenRefreshRequest {
  final String refresh;

  TokenRefreshRequest({
    required this.refresh,
  });

  factory TokenRefreshRequest.fromJson(Map<String, dynamic> json) =>
      TokenRefreshRequest(
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
      };
}
