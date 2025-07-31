import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';
import 'package:instagram_flutter/apps/config/routes.dart';
import 'package:instagram_flutter/dto/toggle_save_post_dto.dart';

class SavePostApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> toggleSavePost(ToggleSavePostDto toggleSavePostDto) async {
    try {
      final response = await dio.post(
        Routes.savePost,
        data: toggleSavePostDto.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to toggle save post');
    }
  }
}
