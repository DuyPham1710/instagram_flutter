import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(CupertinoIcons.lock, size: 16.h, color: Colors.black),
              SizedBox(width: 4.w),
              Text(
                'duy__pham___',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 4.w),
              Icon(
                CupertinoIcons.chevron_down,
                size: 16.h,
                color: Colors.black,
              ),
            ],
          ),

          Row(
            children: [
              IconButton(
                padding: EdgeInsets.only(left: 15.w),
                icon: Icon(
                  CupertinoIcons.plus_app,
                  size: 24.h,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                padding: EdgeInsets.only(left: 15.w),
                icon: Icon(
                  CupertinoIcons.line_horizontal_3,
                  size: 24.h,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
