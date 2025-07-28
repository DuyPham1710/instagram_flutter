import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/routes.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';

class UserApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> getProfile() async {
    try {
      final response = await dio.get(Routes.userProfile);
      //print('Response: ${response.data}');
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get profile');
    }
  }

  Future<dynamic> getAllUsersOther() async {
    try {
      final response = await dio.get(Routes.allUsersOther);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get all users');
    }
  }
}
