import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_actions.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_header.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_info.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_suggest.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: [
              ProfileHeader(),
              ProfileInfo(),
              ProfileActions(),
              ProfileSuggest(),
            ],
          ),
        ),
      ),
    );
  }
}
