import 'package:instagram_flutter/services/api/auth_api_service.dart';

class AuthRepository {
  final AuthApiService authApiService;

  AuthRepository({required this.authApiService});

  Future<String> loginUser(String username, String password) async {
    final response = await authApiService.login(username, password);

    if (response.statusCode != 201) {
      throw Exception('Login failed: ${response.data}');
    }
    return response.data['token'];
  }
}
