import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/routes.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';

class PostApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> getAllPostsByUser() async {
    try {
      final response = await dio.get(Routes.getAllPostsByUser);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get all posts by user');
    }
  }
}
