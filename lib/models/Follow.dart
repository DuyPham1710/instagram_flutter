import 'package:instagram_flutter/dto/user_response_dto.dart';

class Follow {
  final int followId;
  final UserResponseDto? follower; // người theo dõi mình
  final UserResponseDto? following; // mình đang theo dõi ai
  final DateTime createdAt;

  Follow({
    required this.followId,
    this.follower,
    this.following,
    required this.createdAt,
  });

  factory Follow.fromJson(Map<String, dynamic> json) {
    return Follow(
      followId: json['followId'],
      follower: json['follower'] != null
          ? UserResponseDto.fromJson(json['follower'])
          : null,
      following: json['following'] != null
          ? UserResponseDto.fromJson(json['following'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'followId': followId,
      'follower': follower?.toJson(),
      'following': following?.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
