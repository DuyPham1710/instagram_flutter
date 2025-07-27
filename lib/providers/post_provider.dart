import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/repositories/post_repository.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository postRepository;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  PostProvider({required this.postRepository});

  Future<void> fetchAllPosts() async {
    try {
      _posts = await postRepository.getAllPostsByUser();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch all posts: $e');
    }
  }
}
