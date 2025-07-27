import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTabs extends StatefulWidget {
  const ProfileTabs({super.key});

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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

          // Tab nội dung
          SizedBox(
            height: 300.h, // hoặc tính động theo content
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Grid View')),
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
