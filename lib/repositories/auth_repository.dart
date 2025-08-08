import 'package:dio/dio.dart';
import 'package:instagram_flutter/services/api/auth_api_service.dart';

class AuthRepository {
  final AuthApiService authApiService;

  AuthRepository({required this.authApiService});

  Future<String> loginUser(String username, String password) async {
    final response = await authApiService.login(username, password);
    // print('>>> check response: ${response.data}');
    // if (response.statusCode != 201) {
    //   throw DioException(
    //     requestOptions: response.requestOptions,
    //     response: response,
    //     type: DioExceptionType.badResponse,
    //   );
    // }
    return response.data['token'];
  }
}
