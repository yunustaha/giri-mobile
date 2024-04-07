import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Api {
  late BaseOptions options;
  late Dio dio;

  Api() {
    options = BaseOptions(
      baseUrl: dotenv.env['BASE_URL'] ?? '',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${_getTokenFromHive()}",
      },
    );

    dio = Dio(options);
  }

  Future<String?> _getTokenFromHive() async {
    // Hive'den tokeni al
    final box = Hive.box('auth');
    String? token = box.get('token');

    return token;
  }

  Future<Response<dynamic>> getRequest(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response<dynamic>> postRequest(String path, dynamic data) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response<dynamic>> putRequest(String path, dynamic data) async {
    try {
      return await dio.put(path, data: data);
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response<dynamic>> deleteRequest(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await dio.delete(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
