import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_post_item.dart';

class ProfileTabs extends StatefulWidget {
  final List<Post> posts;
  const ProfileTabs({super.key, required this.posts});

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int crossAxisCount = 3;
  double childAspectRatio = 0.8; // childAspectRatio = width / height
  double spacing = 1.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          // Trigger rebuild khi chuyển tab
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double _calculateGridHeight(int itemCount) {
    if (itemCount == 0) {
      return 200.0; // Chiều cao tối thiểu khi không có posts
    }

    // Tính số hàng cần thiết
    final int rows = (itemCount / crossAxisCount).ceil();

    // Tính chiều cao của mỗi item (width / aspectRatio)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth =
        (screenWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;
    final double itemHeight = itemWidth / childAspectRatio;

    // Tính tổng chiều cao cần thiết
    final double calculatedHeight = rows * itemHeight + (rows - 1) * spacing;

    // Đảm bảo chiều cao không âm và có giá trị tối thiểu
    return calculatedHeight > 0 ? calculatedHeight : 200.0;
  }

  @override
  Widget build(BuildContext context) {
    final posts = widget.posts;
    final itemCount = posts.length;

    // Tính toán chiều cao động với giá trị tối thiểu
    double tabHeight;
    if (_tabController.index == 0) {
      tabHeight = _calculateGridHeight(itemCount);
    } else if (_tabController.index == 1) {
      tabHeight = 200.0; // Chiều cao cho tab 2
    } else {
      tabHeight = 200.0; // Chiều cao cho tab 3
    }

    // Đảm bảo tabHeight luôn dương
    tabHeight = tabHeight.abs().clamp(100.0, double.infinity);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.0, color: Colors.black),
              insets: EdgeInsets.symmetric(horizontal: 20.0),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(
                icon: Icon(CupertinoIcons.rectangle_split_3x3_fill),
              ), // Bài viết
              Tab(icon: Icon(CupertinoIcons.play_rectangle)), // Reels
              Tab(
                icon: Icon(CupertinoIcons.person_crop_rectangle),
              ), // Được gắn thẻ
            ],
          ),

          SizedBox(
            height: tabHeight,
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Tab Posts
                posts.isEmpty
                    ? Center(
                        child: Text(
                          'No Posts Yet',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: spacing,
                          mainAxisSpacing: spacing,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          return ProfilePostItem(
                            posts: posts,
                            post: post.images.isNotEmpty ? post : null,
                          );
                        },
                      ),
                Center(
                  child: Text(
                    'Share a moment with everyone',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Photos and videos you\'re tagged in',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
