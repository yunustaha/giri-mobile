import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:giri/services/Auth/models/login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../api.dart'; // Api sınıfını içe aktar

class AuthService {
  final Api _api = Api(); // Api sınıfından bir örnek oluştur

  Future<void> _saveUserToken(String token) async {
    final secureKey = Hive.generateSecureKey();
    final encryptedBox = await Hive.openBox('auth', encryptionCipher: HiveAesCipher(secureKey));
    await encryptedBox.put('token', token);
  }

  Future<dynamic> login(Map<String, dynamic> loginData) async {
    try {
      // Api sınıfındaki request metodu ile login isteği yap
      Response<dynamic> response = await _api.postRequest(
        '/auth/login',
        {
          "data": {
            "username": loginData['username'],
            "password": loginData['password'],
          }
        },
      );

      LoginModel data = LoginModel.fromJson(response.data);

      if (loginData['rememberme'] == true) {
        final box = Hive.box('remember');
        box.put('data', jsonEncode(loginData));
      }

      await _saveUserToken(data.accessToken);
    } catch (e) {
      rethrow;
    }
  }
}
