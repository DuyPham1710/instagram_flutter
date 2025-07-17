import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('images/logo.jpg', height: 32.h),
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.only(left: 15.w),
                icon: Icon(CupertinoIcons.heart, color: Colors.black, size: 24),
                onPressed: () {},
              ),
              IconButton(
                padding: EdgeInsets.only(left: 15.w),
                icon: Icon(
                  CupertinoIcons.chat_bubble_text,
                  color: Colors.black,
                  size: 24,
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
