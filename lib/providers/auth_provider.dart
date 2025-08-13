import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';
import 'package:instagram_flutter/dto/ApiResponse.dart';
import 'package:instagram_flutter/dto/create_user_dto.dart';
import 'package:instagram_flutter/dto/login_dto.dart';
import 'package:instagram_flutter/dto/verify_account_dto.dart';
import 'package:instagram_flutter/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  AuthProvider({required this.repository});

  String? _token;

  String? get token => _token;

  Future<String?> login(LoginDto loginDto) async {
    try {
      _token = await repository.loginUser(loginDto);

      DioClient().updateToken(_token!);

      // Lưu token vào SharedPreferences
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('accessToken', _token!);

      notifyListeners();
      return null;
    } on DioException catch (e) {
      //   print('>>> check ${e.response}');
      // Nếu API có trả message
      if (e.response?.data != null) {
        try {
          final apiResponse = ApiResponse.fromJson(e.response!.data);
          return apiResponse.message;
        } catch (_) {
          return e.response?.data.toString();
        }
      }
      return "Server error";
    } catch (e) {
      return "Unknown error occurred";
    }
  }

  Future<String?> register(CreateUserDto userData) async {
    try {
      final response = await repository.registerUser(userData);
      print('>>> check register response: ${response.toJson()}');

      return null;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        try {
          final apiResponse = ApiResponse.fromJson(e.response!.data);
          return apiResponse.message;
        } catch (_) {
          return e.response?.data.toString();
        }
      }
      return "Server error";
    } catch (e) {
      return "Unknown error occurred";
    }
  }

  Future<String?> verifyUser(VerifyAccountDto verifyAccountDto) async {
    try {
      final response = await repository.verifyUser(verifyAccountDto);
      print('>>> check verify response: ${response.toJson()}');

      return null;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        try {
          final apiResponse = ApiResponse.fromJson(e.response!.data);
          return apiResponse.message;
        } catch (_) {
          return e.response?.data.toString();
        }
      }
      return "Server error";
    } catch (e) {
      return "Unknown error occurred";
    }
  }

  Future<String?> resendOtp(String email) async {
    try {
      final response = await repository.resendOtp(email);

      return response;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        try {
          final apiResponse = ApiResponse.fromJson(e.response!.data);
          return apiResponse.message;
        } catch (_) {
          return e.response?.data.toString();
        }
      }
      return "Server error";
    } catch (e) {
      return "Unknown error occurred";
    }
  }
}
