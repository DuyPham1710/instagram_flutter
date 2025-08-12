import 'package:instagram_flutter/dto/create_comment_dto.dart';
import 'package:instagram_flutter/models/Comment.dart';
import 'package:instagram_flutter/services/api/comment_api_service.dart';

class CommentRepository {
  final CommentApiService commentApiService;

  CommentRepository({required this.commentApiService});

  Future<Comment> createComment(CreateCommentDto dto) async {
    final response = await commentApiService.createComment(dto);
    return (Comment.fromJson(response.data));
  }
}
