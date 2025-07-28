import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/providers/Follow_provider.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/screens/follow/follow_screen.dart';
import 'package:provider/provider.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => ProfileInfoState();
}

class ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;

        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50.h,
                backgroundImage: NetworkImage(
                  user?.avatarUrl ??
                      'https://instagram.fsgn20-1.fna.fbcdn.net/v/t51.2885-15/509172123_17953054133977776_1499235394796415359_n.jpg?stp=dst-jpg_e35_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6IkNBUk9VU0VMX0lURU0uaW1hZ2VfdXJsZ2VuLjE0NDB4MTkwNC5zZHIuZjc1NzYxLmRlZmF1bHRfaW1hZ2UuYzIifQ&_nc_ht=instagram.fsgn20-1.fna.fbcdn.net&_nc_cat=100&_nc_oc=Q6cZ2QGA3aGoj5kpA1Dd72yHSFuNEg24BgpTmASxe0LK9nfxsizuJd9ixEHlBksOO7E-DriTe8ZS5zxEyhcCm6BR0hM6&_nc_ohc=pdZskyjJk1MQ7kNvwGf4gXZ&_nc_gid=E5l0UN6k9qq71kYx9mwurQ&edm=AP4sbd4BAAAA&ccb=7-5&ig_cache_key=MzY1NzcwNzAyMzQ5MzQ5MDI3OQ%3D%3D.3-ccb7-5&oh=00_AfTCuR7ScX1XkEZQYmO-NvJ2_3MqmAP2ys4WnyMOkGRU9Q&oe=68885D77&_nc_sid=7a9f4b',
                ),
              ),

              SizedBox(width: 20.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.fullName ?? 'Unknown',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<PostProvider>(
                              builder: (context, postProvider, child) {
                                return Text(
                                  '${postProvider.posts.length}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
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
                              Consumer<FollowProvider>(
                                builder: (context, followProvider, child) {
                                  return Text(
                                    '${followProvider.followers.length}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
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
                              Consumer<FollowProvider>(
                                builder: (context, followProvider, child) {
                                  return Text(
                                    '${followProvider.following.length}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
