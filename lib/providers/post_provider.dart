import 'package:flutter/material.dart';
import 'package:instagram_flutter/dto/toggle_like_dto.dart';
import 'package:instagram_flutter/dto/toggle_save_post_dto.dart';
import 'package:instagram_flutter/models/Like.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/models/SavePost.dart';
import 'package:instagram_flutter/repositories/like_repository.dart';
import 'package:instagram_flutter/repositories/post_repository.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository postRepository;
  final LikeRepository likeRepository;

  bool _isReady = false;
  bool get isReady => _isReady;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  List<Post> _postsFollowing = [];
  List<Post> get postsFollowing => _postsFollowing;

  List<SavePost> _savedPosts = [];
  List<SavePost> get savedPosts => _savedPosts;

  List<Like> _likedPosts = [];
  List<Like> get likedPosts => _likedPosts;

  PostProvider({required this.postRepository, required this.likeRepository});

  Future<void> initializeHomeData() async {
    try {
      await fetchAllPostsFollowing();
      await fetchSavedPosts();
      await fetchLikedPosts();
      _isReady = true;
      notifyListeners();
    } catch (e) {
      print('Failed to initialize home data: $e');
    }
  }

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

  Future<void> fetchSavedPosts() async {
    try {
      _savedPosts = await postRepository.getSavedPosts();

      for (var savedPost in _savedPosts) {
        final index = _postsFollowing.indexWhere(
          (p) => p.postId == savedPost.post.postId,
        );
        if (index != -1) {
          _postsFollowing[index].isSaved = true;
        }
      }

      notifyListeners();
    } catch (e) {
      print('Failed to fetch saved posts: $e');
    }
  }

  Future<void> fetchLikedPosts() async {
    try {
      _likedPosts = await likeRepository.getLikedPosts();

      for (var like in _likedPosts) {
        final index = _postsFollowing.indexWhere(
          (p) => p.postId == like.post.postId,
        );
        if (index != -1) {
          _postsFollowing[index].isLiked = true;
        }
      }

      notifyListeners();
    } catch (e) {
      print('Failed to fetch liked posts: $e');
    }
  }
}
