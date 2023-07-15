// To parse this JSON data, do
//
//     final tokens = tokensFromJson(jsonString);

import 'dart:convert';

Tokens tokensFromJson(String str) => Tokens.fromJson(json.decode(str));

String tokensToJson(Tokens data) => json.encode(data.toJson());

class Tokens {
  final String refresh;
  final String access;

  Tokens({
    required this.refresh,
    required this.access,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
