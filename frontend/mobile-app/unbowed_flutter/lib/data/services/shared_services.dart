import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/register/register_response_model.dart';

class SharedService {
  static final SharedService _instance = SharedService._internal();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  factory SharedService() => _instance;

  SharedService._internal();

  Future<bool> isLoggedIn() async {
    bool isKeyExists = await _storage.containsKey(key: 'login_details');
    return isKeyExists;
  }

  Future<RegisterResponseModel?> getLoginDetails() async {
    var loginDetails = await _storage.read(key: 'login_details');
    if (loginDetails != null) {
      return registerResponseModelFromJson(loginDetails);
    } else {
      return null;
    }
  }

  Future<void> setLoginDetails(RegisterResponseModel loginDetails) async {
    String userJson = jsonEncode(loginDetails.toJson());

    await _storage.write(
      key: 'login_details',
      value: userJson,
    );
  }

  Future<void> logout() async {
    await _storage.delete(key: 'login_details');
  }
}
