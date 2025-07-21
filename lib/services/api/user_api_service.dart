import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/api_path.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';

class UserApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> getProfile() async {
    try {
      final response = await dio.get(ApiPath.userProfile);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get profile');
    }
  }
}
