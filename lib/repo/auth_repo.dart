import 'dart:developer';

import 'package:dio/dio.dart';

import '../utils/constant.dart';
import '../utils/custom_storage.dart';

class AuthRepo {
  final Dio _dio = Dio();

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiUrl.basUrl}/user/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200 && response.data['success'] == true) {
        print('User registered successfully');
      } else {
        // Handle error response
        throw Exception('Failed to register user');
      }
    } catch (e) {
      throw Exception('Error registering user: $e');
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiUrl.basUrl}/user/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200 && response.data['success'] == true) {
        log("Login successful");
        ApiToken.token = response.data['token'];
        writeTokenAccess(ApiToken.token);
        return response.data;
      } else if (response.statusCode == 400 &&
          response.data['status'] == false) {
        log("Login failed ${response.data['errors']}");
        return response.data['errors'];
      } else {
        throw response.data['errors'];
      }
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }
}
