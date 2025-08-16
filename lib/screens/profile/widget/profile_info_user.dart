import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/models/Follow.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/providers/Follow_provider.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/screens/follow/follow_screen.dart';
import 'package:instagram_flutter/screens/post/post_screen.dart';
import 'package:provider/provider.dart';

class ProfileInfoUser extends StatefulWidget {
  final UserResponseDto user;
  const ProfileInfoUser({super.key, required this.user});

  @override
  State<ProfileInfoUser> createState() => ProfileInfoUserState();
}

class ProfileInfoUserState extends State<ProfileInfoUser> {
  late Future<List<dynamic>> _profileDataFuture;

  @override
  void initState() {
    super.initState();
    fetchUserPosts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchUserPosts() async {
    final userId = widget.user.userId;
    _profileDataFuture = Future.wait([
      Provider.of<PostProvider>(
        context,
        listen: false,
      ).fetchPostsByUserId(userId),
      Provider.of<FollowProvider>(
        context,
        listen: false,
      ).fetchFollowersByUserId(userId),
      Provider.of<FollowProvider>(
        context,
        listen: false,
      ).fetchFollowingByUserId(userId),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50.h,
                backgroundImage: NetworkImage(
                  user.avatarUrl ??
                      'https://cdn.shopify.com/s/files/1/0086/0795/7054/files/Golden-Retriever.jpg?v=1645179525',
                ),
              ),

              SizedBox(width: 20.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName ?? 'Unknown',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    FutureBuilder(
                      future: _profileDataFuture,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                              'Error fetching posts data',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          );
                        }

                        final posts = snapshot.data![0] as List<Post>;
                        final followers = snapshot.data![1] as List<Follow>;
                        final following = snapshot.data![2] as List<Follow>;

                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostScreen(
                                      posts: posts,
                                      selectedPostIndex: 0,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${posts.length}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 4.h),

                                  Text(
                                    'bài viết',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 14.w),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        FollowScreen(initialTabIndex: 0),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${followers.length}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 4.h),

                                  Text(
                                    'người theo dõi',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 14.w),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        FollowScreen(initialTabIndex: 1),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${following.length}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'đang theo dõi',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),
          Text(
            user.bio ?? '',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
