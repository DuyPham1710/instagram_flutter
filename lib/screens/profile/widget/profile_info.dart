import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/providers/Follow_provider.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/screens/follow/follow_screen.dart';
import 'package:instagram_flutter/screens/post/post_screen.dart';
import 'package:provider/provider.dart';

class ProfileInfo extends StatefulWidget {
  final UserResponseDto? user;
  const ProfileInfo({super.key, this.user});

  @override
  State<ProfileInfo> createState() => ProfileInfoState();
}

class ProfileInfoState extends State<ProfileInfo> {
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
                  user?.avatarUrl ??
                      'https://cdn.shopify.com/s/files/1/0086/0795/7054/files/Golden-Retriever.jpg?v=1645179525',
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostScreen(
                                  posts: context.read<PostProvider>().posts,
                                  selectedPostIndex: 0,
                                ),
                              ),
                            );
                          },
                          child: Column(
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

          SizedBox(height: 10.h),
          Text(
            user?.bio ?? '',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
