import 'package:instagram_flutter/dto/toggle_like_dto.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/services/api/like_api_service.dart';

class LikeRepository {
  final LikeApiService likeApiService;

  LikeRepository({required this.likeApiService});

  Future<dynamic> toggleLikePost(ToggleLikeDto toggleLikeDto) async {
    final response = await likeApiService.toggleLikePost(toggleLikeDto);

    if (response.statusCode != 201) {
      throw Exception('Failed to toggle like post: ${response.data}');
    }
    // print('response.data: ${response.data}');
    return Post.fromJson(response.data);
  }
}
