import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';
import 'package:instagram_flutter/apps/config/routes.dart';
import 'package:instagram_flutter/dto/create_comment_dto.dart';

class CommentApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> createComment(CreateCommentDto dto) async {
    try {
      final response = await dio.post(Routes.createComment, data: dto.toJson());
      return response;
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: DioExceptionType.badResponse,
      );
    }
  }
}
