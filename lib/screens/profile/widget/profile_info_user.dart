import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/models/Follow.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/providers/Follow_provider.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/screens/follow/follow_screen.dart';
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
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50.h,
            backgroundImage: NetworkImage(
              user.avatarUrl ??
                  'https://instagram.fsgn20-1.fna.fbcdn.net/v/t51.2885-15/509172123_17953054133977776_1499235394796415359_n.jpg?stp=dst-jpg_e35_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6IkNBUk9VU0VMX0lURU0uaW1hZ2VfdXJsZ2VuLjE0NDB4MTkwNC5zZHIuZjc1NzYxLmRlZmF1bHRfaW1hZ2UuYzIifQ&_nc_ht=instagram.fsgn20-1.fna.fbcdn.net&_nc_cat=100&_nc_oc=Q6cZ2QGA3aGoj5kpA1Dd72yHSFuNEg24BgpTmASxe0LK9nfxsizuJd9ixEHlBksOO7E-DriTe8ZS5zxEyhcCm6BR0hM6&_nc_ohc=pdZskyjJk1MQ7kNvwGf4gXZ&_nc_gid=E5l0UN6k9qq71kYx9mwurQ&edm=AP4sbd4BAAAA&ccb=7-5&ig_cache_key=MzY1NzcwNzAyMzQ5MzQ5MDI3OQ%3D%3D.3-ccb7-5&oh=00_AfTCuR7ScX1XkEZQYmO-NvJ2_3MqmAP2ys4WnyMOkGRU9Q&oe=68885D77&_nc_sid=7a9f4b',
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          'Error fetching posts data',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      );
                    }

                    final posts = snapshot.data![0] as List<Post>;
                    final followers = snapshot.data![1] as List<Follow>;
                    final following = snapshot.data![2] as List<Follow>;

                    return Row(
                      children: [
                        Column(
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
    );
  }
}
