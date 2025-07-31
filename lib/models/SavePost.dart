import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/models/Post.dart';

class SavePost {
  final int savePostId;
  final UserResponseDto user;
  final Post post;

  SavePost({required this.savePostId, required this.user, required this.post});

  factory SavePost.fromJson(Map<String, dynamic> json) {
    return SavePost(
      savePostId: json['savePostId'],
      user: UserResponseDto.fromJson(json['user']),
      post: Post.fromJson(json['post']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'savePostId': savePostId,
      'user': user.toJson(),
      'post': post.toJson(),
    };
  }
}
