import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_post_item.dart';

class ProfileTabs extends StatefulWidget {
  const ProfileTabs({super.key});

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int itemCount = 39;
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

  double _calculateGridHeight() {
    // Tính số hàng cần thiết
    final int rows = (itemCount / crossAxisCount).ceil();

    // Tính chiều cao của mỗi item (width / aspectRatio)
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth =
        (screenWidth - (crossAxisCount - 1) * spacing) / crossAxisCount;
    final double itemHeight = itemWidth / childAspectRatio;

    // Tính tổng chiều cao cần thiết
    return rows * itemHeight + (rows - 1) * spacing;
  }

  @override
  Widget build(BuildContext context) {
    // Tính toán chiều cao động
    double tabHeight;
    if (_tabController.index == 0) {
      tabHeight = _calculateGridHeight();
    } else if (_tabController.index == 1) {
      tabHeight = 200; // Chiều cao cho tab 2
    } else {
      tabHeight = 150; // Chiều cao cho tab 3
    }

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
                GridView.builder(
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
                    return const ProfilePostItem();
                  },
                ),
                Center(child: Text('Chia sẻ khoảng khắc với tất cả mọi người')),
                Center(child: Text('Ảnh và video được gắn thẻ')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
