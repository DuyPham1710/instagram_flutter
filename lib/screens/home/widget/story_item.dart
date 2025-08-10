import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';

class StoryItem extends StatelessWidget {
  final int index;
  final UserResponseDto user;

  const StoryItem({super.key, required this.index, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 86.w,
                height: 86.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.pink, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 3.h),
                ),
                child: CircleAvatar(
                  radius: 40.r,
                  backgroundImage: NetworkImage(user.avatarUrl ?? ''),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(user.username, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }
}
