import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/models/Comment.dart';
import 'package:instagram_flutter/models/Like.dart';
import 'package:instagram_flutter/models/PostImages.dart';

class Post {
  final int postId;
  final String? caption;
  final UserResponseDto? user;
  final List<PostImages> images;
  final DateTime createdAt;
  bool? isSaved;
  bool? isLiked;
  int likeCount = 0;
  List<Like> likePost;
  List<Comment> comments;

  Post({
    required this.postId,
    this.caption,
    this.user,
    required this.images,
    required this.createdAt,
    this.isSaved = false,
    this.isLiked = false,
    this.likeCount = 0,
    this.likePost = const [],
    this.comments = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    final List<Like> parsedLikes =
        (json['likePost'] as List?)
            ?.map((like) => Like.fromJsonSimple(like))
            .toList() ??
        [];

    final List<Comment> parsedComments =
        (json['comments'] as List?)
            ?.map((comment) => Comment.fromJson(comment))
            .toList() ??
        [];

    return Post(
      postId: json['postId'],
      caption: json['caption'],
      user: json['user'] != null
          ? UserResponseDto.fromJson(json['user'])
          : null,
      images: (json['images'] as List)
          .map((image) => PostImages.fromJson(image))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      isSaved: json['isSaved'] != null ? json['isSaved'] as bool : false,
      isLiked: json['isLiked'] != null ? json['isLiked'] as bool : false,
      likeCount: parsedLikes.length,
      likePost: parsedLikes,
      comments: parsedComments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'caption': caption,
      'images': images.map((image) => image.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'isSaved': isSaved,
      'isLiked': isLiked,
      'likeCount': likeCount,
      'likePost': likePost.map((like) => like.toJson()).toList(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }
}
