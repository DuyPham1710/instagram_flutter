import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSuggest extends StatefulWidget {
  const ProfileSuggest({super.key});

  @override
  State<ProfileSuggest> createState() => ProfileSuggestState();
}

class ProfileSuggestState extends State<ProfileSuggest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 200.h,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Khám phá mọi người',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Xem tất cả',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Text(
            'Profile Suggestions Screen',
            style: TextStyle(fontSize: 24.sp, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
