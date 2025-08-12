import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/dto/ApiResponse.dart';
import 'package:instagram_flutter/dto/create_comment_dto.dart';
import 'package:instagram_flutter/models/Comment.dart';
import 'package:instagram_flutter/repositories/comment_repository.dart';

class CommentProvider extends ChangeNotifier {
  final CommentRepository commentRepository;

  CommentProvider({required this.commentRepository});

  Future<Comment?> createComment(CreateCommentDto dto) async {
    try {
      final data = await commentRepository.createComment(dto);
      return data;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        try {
          final apiResponse = ApiResponse.fromJson(e.response!.data);
          print('Error creating comment: ${apiResponse.message}');
          return null;
        } catch (_) {
          return null;
        }
      }
      print('Error creating comment: ${e.message}');
      return null;
    } catch (e) {
      return null;
    }
  }
}
