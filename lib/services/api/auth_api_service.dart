import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/routes.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';

class AuthApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> login(String username, String password) async {
    try {
      final response = await dio.post(
        Routes.login,
        data: {'username': username, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Login failed');
    }
  }

  // Future<dynamic> getUserProfile() async {
  //   try {
  //     final response = await dio.get(ApiPath.userProfile);
  //     return response.data;
  //   } on DioException catch (e) {
  //     throw Exception(e.response?.data ?? 'Failed to get profile');
  //   }
  // }
}
