import 'package:flutter/material.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';
import 'package:instagram_flutter/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  AuthProvider({required this.repository});

  String? _token;

  String? get token => _token;

  Future<void> login(String email, String password) async {
    try {
      _token = await repository.loginUser(email, password);

      DioClient().updateToken(_token!);

      // Lưu token vào SharedPreferences
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('accessToken', _token!);

      notifyListeners();
    } catch (e) {
      print('Login failed: $e');
    }
  }
}
