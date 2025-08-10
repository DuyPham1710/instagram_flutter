import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_info_user.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_story.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_tabs.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  final UserResponseDto user;
  const UserProfileScreen({super.key, required this.user});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<List<Post>> _fetchUserPosts;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchUserPosts = context.read<PostProvider>().fetchPostsByUserId(
      widget.user.userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: GestureDetector(
          child: Icon(CupertinoIcons.back, color: Colors.black),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          widget.user.username,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.ellipsis, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          ProfileInfoUser(user: widget.user),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionButton('Theo dõi', onPressed: () {}),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildActionButton('Nhắn tin', onPressed: () {}),
                ),
                SizedBox(width: 8.w),
                _buildIconButton(Icons.person_add_alt_1_outlined),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          ProfileStory(),
          FutureBuilder(
            future: _fetchUserPosts,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (asyncSnapshot.hasError) {
                return Center(child: Text('Error: ${asyncSnapshot.error}'));
              } else {
                final posts = asyncSnapshot.data as List<Post>;
                return ProfileTabs(posts: posts);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, {required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 36.h,
        decoration: BoxDecoration(
          color: text == 'Theo dõi' ? Colors.blueAccent : Colors.grey[100],
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: text == 'Theo dõi' ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      alignment: Alignment.center,
      height: 36.h,
      width: 36.w,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: InkWell(
        onTap: () {
          // Handle icon button tap
        },
        child: Icon(
          CupertinoIcons.person_add_solid,
          size: 22.h,
          color: Colors.black,
        ),
      ),
    );
  }
}
