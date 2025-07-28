import 'package:instagram_flutter/models/Follow.dart';
import 'package:instagram_flutter/services/api/follow_api_service.dart';

class FollowRepository {
  final FollowApiService followApiService;

  FollowRepository({required this.followApiService});

  Future<dynamic> getFollowers() async {
    final response = await followApiService.getFollowers();

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch followers: ${response.data}');
    }
    return (response.data as List)
        .map((followerItem) => Follow.fromJson(followerItem))
        .toList();
  }

  Future<dynamic> getFollowing() async {
    final response = await followApiService.getFollowing();

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch following: ${response.data}');
    }
    return (response.data as List)
        .map((followingItem) => Follow.fromJson(followingItem))
        .toList();
  }
}
