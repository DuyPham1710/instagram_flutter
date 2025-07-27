import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/services/api/user_api_service.dart';

class UserRepository {
  final UserApiService userApiService;

  UserRepository({required this.userApiService});

  Future<UserResponseDto> getUserProfile() async {
    final response = await userApiService.getProfile();

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch user profile: ${response.data}');
    }

    return UserResponseDto.fromJson(response.data);
  }

  Future<List<UserResponseDto>> getAllUsersOther() async {
    final response = await userApiService.getAllUsersOther();

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch all users: ${response.data}');
    }

    return (response.data as List)
        .map((user) => UserResponseDto.fromJson(user))
        .toList();
  }
}
