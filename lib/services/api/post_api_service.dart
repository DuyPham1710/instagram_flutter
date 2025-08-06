import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/routes.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';

class PostApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> getAllPostsByUserId(int userId) async {
    try {
      final response = await dio.get(
        Routes.getAllPostsByUserId(userId),
        queryParameters: {'userId': userId},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get posts by user ID');
    }
  }

  Future<dynamic> getAllPostsByUser() async {
    try {
      final response = await dio.get(Routes.getAllPostsByUser);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get all posts by user');
    }
  }

  Future<dynamic> getAllPostsFollowing() async {
    try {
      final response = await dio.get(Routes.getAllPostsFollowing);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get all posts following');
    }
  }
}
