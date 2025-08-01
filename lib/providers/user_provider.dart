import 'package:flutter/material.dart';
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
}
