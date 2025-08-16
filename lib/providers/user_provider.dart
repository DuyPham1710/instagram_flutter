import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/dto/ApiResponse.dart';
import 'package:instagram_flutter/dto/update_user_dto.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository repository;

  UserProvider({required this.repository});

  UserResponseDto? _user;

  UserResponseDto? get user => _user;

  Future<void> fetchUserProfile() async {
    try {
      _user = await repository.getUserProfile();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch user profile: $e');
    }
  }

  Future<List<UserResponseDto>> fetchAllUsersOther() async {
    try {
      final users = await repository.getAllUsersOther();
      return users;
    } catch (e) {
      print('Failed to fetch all users: $e');
      return [];
    }
  }

  Future<String?> updateUserProfile(
    UpdateUserDto data, {
    File? avatarFile,
  }) async {
    try {
      _user = await repository.updateUserProfile(data, avatarFile: avatarFile);
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
}
