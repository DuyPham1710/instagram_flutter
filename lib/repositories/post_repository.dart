import 'package:instagram_flutter/dto/toggle_save_post_dto.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/models/SavePost.dart';
import 'package:instagram_flutter/services/api/post_api_service.dart';
import 'package:instagram_flutter/services/api/save_post_api_service.dart';

class PostRepository {
  final PostApiService postApiService;
  final SavePostApiService savePostApiService;

  PostRepository({
    required this.postApiService,
    required this.savePostApiService,
  });

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

  Future<dynamic> getAllPostsFollowing() async {
    final response = await postApiService.getAllPostsFollowing();

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch following posts: ${response.data}');
    }
    // print('response.data: ${response.data['likePost']}');
    return (response.data as List)
        .map((postItem) => Post.fromJson(postItem))
        .toList();
  }

  Future<dynamic> toggleSavePost(ToggleSavePostDto toggleSavePostDto) async {
    final response = await savePostApiService.toggleSavePost(toggleSavePostDto);

    if (response.statusCode != 201) {
      throw Exception('Failed to toggle save post: ${response.data}');
    }

    return Post.fromJson(response.data);
  }

  Future<List<SavePost>> getSavedPosts() async {
    final response = await savePostApiService.getSavedPosts();

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch saved posts: ${response.data}');
    }

    return (response.data as List)
        .map((savedPostItem) => SavePost.fromJson(savedPostItem))
        .toList();
  }
}
