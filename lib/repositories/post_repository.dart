import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/services/api/post_api_service.dart';

class PostRepository {
  final PostApiService postApiService;

  PostRepository({required this.postApiService});

  Future<dynamic> getAllPostsByUser() async {
    final response = await postApiService.getAllPostsByUser();

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch posts: ${response.data}');
    }
    // print('response.data: ${response.data}');
    return (response.data as List)
        .map((postItem) => Post.fromJson(postItem))
        .toList();
  }
}
