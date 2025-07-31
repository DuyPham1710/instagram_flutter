import 'package:flutter/material.dart';
import 'package:instagram_flutter/dto/toggle_like_dto.dart';
import 'package:instagram_flutter/dto/toggle_save_post_dto.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/repositories/like_repository.dart';
import 'package:instagram_flutter/repositories/post_repository.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository postRepository;
  final LikeRepository likeRepository;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  List<Post> _postsFollowing = [];
  List<Post> get postsFollowing => _postsFollowing;

  PostProvider({required this.postRepository, required this.likeRepository});

  Future<void> fetchAllPosts() async {
    try {
      _posts = await postRepository.getAllPostsByUser();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch all posts: $e');
    }
  }

  Future<void> fetchAllPostsFollowing() async {
    try {
      _postsFollowing = await postRepository.getAllPostsFollowing();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch all following posts: $e');
    }
  }

  Future<void> savePost(ToggleSavePostDto toggleSavePostDto) async {
    try {
      final updatedPost = await postRepository.toggleSavePost(
        toggleSavePostDto,
      );

      final index = _postsFollowing.indexWhere(
        (p) => p.postId == toggleSavePostDto.postId,
      );

      if (index != -1) {
        _postsFollowing[index].isSaved = updatedPost.isSaved;
      }

      notifyListeners();
    } catch (e) {
      print('Failed to save post: $e');
      rethrow;
    }
  }

  Future<void> toggleLikePost(ToggleLikeDto toggleLikeDto) async {
    try {
      final updatedPost = await likeRepository.toggleLikePost(toggleLikeDto);

      final index = _postsFollowing.indexWhere(
        (p) => p.postId == toggleLikeDto.postId,
      );

      if (index != -1) {
        _postsFollowing[index].isLiked = updatedPost.isLiked;
      }

      notifyListeners();
    } catch (e) {
      print('Failed to toggle like post: $e');
      rethrow;
    }
  }
}
