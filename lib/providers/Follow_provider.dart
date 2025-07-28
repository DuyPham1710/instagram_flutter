import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/Follow.dart';
import 'package:instagram_flutter/repositories/follow_repository.dart';

class FollowProvider extends ChangeNotifier {
  final FollowRepository followRepository;

  List<Follow> _followers = [];

  List<Follow> get followers => _followers;

  List<Follow> _following = [];

  List<Follow> get following => _following;

  FollowProvider({required this.followRepository});

  Future<void> fetchFollowers() async {
    try {
      _followers = await followRepository.getFollowers();
      notifyListeners();
    } catch (e) {
      print('Error fetching followers: $e');
    }
  }

  Future<void> fetchFollowing() async {
    try {
      _following = await followRepository.getFollowing();
      notifyListeners();
    } catch (e) {
      print('Error fetching following: $e');
    }
  }
}
