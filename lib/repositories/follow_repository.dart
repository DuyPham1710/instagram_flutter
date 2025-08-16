import 'package:instagram_flutter/dto/toggle_follow_dto.dart';
import 'package:instagram_flutter/models/Follow.dart';
import 'package:instagram_flutter/services/api/follow_api_service.dart';

class FollowRepository {
  final FollowApiService followApiService;

  FollowRepository({required this.followApiService});

  Future<String> toggleFollow(ToggleFollowDto toggleFollowDto) async {
    final response = await followApiService.toggleFollow(toggleFollowDto);

    return response.data['message'];
  }

  Future<List<Follow>> getFollowersByUserId(int userId) async {
    final response = await followApiService.getFollowersByUserId(userId);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch followers: ${response.data}');
    }
    return (response.data as List)
        .map((followerItem) => Follow.fromJson(followerItem))
        .toList();
  }

  Future<List<Follow>> getFollowingByUserId(int userId) async {
    final response = await followApiService.getFollowingByUserId(userId);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch following: ${response.data}');
    }
    return (response.data as List)
        .map((followingItem) => Follow.fromJson(followingItem))
        .toList();
  }

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
