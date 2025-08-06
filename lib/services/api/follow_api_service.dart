import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';
import 'package:instagram_flutter/apps/config/routes.dart';

class FollowApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> getFollowersByUserId(int userId) async {
    try {
      final response = await dio.get(
        Routes.getFollowersByUserId(userId),
        queryParameters: {'userId': userId},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get followers by user ID');
    }
  }

  Future<dynamic> getFollowingByUserId(int userId) async {
    try {
      final response = await dio.get(
        Routes.getFollowingByUserId(userId),
        queryParameters: {'userId': userId},
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get following by user ID');
    }
  }

  Future<dynamic> getFollowers() async {
    try {
      final response = await dio.get(Routes.getFollowers);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get followers');
    }
  }

  Future<dynamic> getFollowing() async {
    try {
      final response = await dio.get(Routes.getFollowing);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get following');
    }
  }
}
