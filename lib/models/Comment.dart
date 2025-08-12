import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/models/Post.dart';

class Comment {
  final int commentId;
  final UserResponseDto user;
  final Post? post;
  final String content;

  Comment({
    required this.commentId,
    required this.user,
    this.post,
    required this.content,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      user: UserResponseDto.fromJson(json['user']),
      post: json['post'] != null ? Post.fromJson(json['post']) : null,
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'user': user.toJson(),
      'post': post?.toJson(),
      'content': content,
    };
  }
}
