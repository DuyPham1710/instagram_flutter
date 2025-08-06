import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_info_user.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_story.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_tabs.dart';

class UserProfileScreen extends StatelessWidget {
  final UserResponseDto user;
  const UserProfileScreen({super.key, required this.user});

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
          user.username,
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            ProfileInfoUser(user: user),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
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
            ProfileTabs(),
          ],
        ),
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
