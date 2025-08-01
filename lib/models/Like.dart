import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/models/Post.dart';

class Like {
  final int likeId;
  final UserResponseDto user;
  final Post? post;

  Like({required this.likeId, required this.user, this.post});

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      likeId: json['likeId'],
      user: UserResponseDto.fromJson(json['user']),
      post: Post.fromJson(json['post']),
    );
  }

  factory Like.fromJsonSimple(Map<String, dynamic> json) {
    return Like(
      likeId: json['likeId'],
      user: UserResponseDto.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'likeId': likeId, 'user': user.toJson(), 'post': post?.toJson()};
  }
}
