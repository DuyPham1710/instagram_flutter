import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';
import 'package:instagram_flutter/apps/config/routes.dart';
import 'package:instagram_flutter/dto/toggle_like_dto.dart';

class LikeApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> toggleLikePost(ToggleLikeDto toggleLikeDto) async {
    try {
      final response = await dio.post(
        Routes.likePost,
        data: toggleLikeDto.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to toggle like post');
    }
  }

  Future<dynamic> getLikedPosts() async {
    try {
      final response = await dio.get(Routes.getLikedPosts);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get liked posts');
    }
  }
}
