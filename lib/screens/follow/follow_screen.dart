import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/providers/Follow_provider.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/screens/follow/widget/follower_item.dart';
import 'package:instagram_flutter/screens/follow/widget/following_item.dart';
import 'package:provider/provider.dart';

class FollowScreen extends StatefulWidget {
  final int initialTabIndex;

  const FollowScreen({super.key, this.initialTabIndex = 0});

  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initialTabIndex,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              final user = userProvider.user;
              return Text(
                user?.username ?? 'Unknown User',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 1,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),

          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.h),
            child: Consumer<FollowProvider>(
              builder: (context, followProvider, child) {
                return TabBar(
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: Colors.black),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  tabs: [
                    Tab(
                      text: '${followProvider.followers.length} Người Theo Dõi',
                    ),
                    Tab(
                      text: '${followProvider.following.length} Đang Theo Dõi',
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        //backgroundColor: Colors.white,
        body: Consumer<FollowProvider>(
          builder: (context, followProvider, _) {
            return TabBarView(
              children: [
                // Tab 1: Người theo dõi
                ListView.builder(
                  itemCount: followProvider.followers.length,
                  itemBuilder: (context, index) {
                    final user = followProvider.followers[index].follower;
                    return FollowerItem(
                      fullName: user?.fullName ?? '',
                      userName: user?.username ?? '',
                      avatarUrl: user?.avatarUrl ?? '',
                    );
                  },
                ),

                // Tab 2: Đang theo dõi
                ListView.builder(
                  itemCount: followProvider.following.length,
                  itemBuilder: (context, index) {
                    final user = followProvider.following[index].following;
                    return FollowingItem(
                      fullName: user?.fullName ?? '',
                      userName: user?.username ?? '',
                      avatarUrl: user?.avatarUrl ?? '',
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
