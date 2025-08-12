import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/screens/profile/user_profile_screen.dart';

class SuggestItem extends StatelessWidget {
  final VoidCallback onClose;
  final UserResponseDto user;

  const SuggestItem({super.key, required this.user, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(user: user),
          ),
        );
      },
      child: Container(
        width: 140.w,
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 243, 243, 243)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 46.r,
                  backgroundImage: NetworkImage(user.avatarUrl ?? ''),
                ),

                SizedBox(height: 12.h),

                Text(
                  user.fullName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 4.h),

                Text(
                  'Có nguyenNhu và 4 người khác',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 4.h),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 34.h),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Text(
                    "Follow",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: onClose,
                child: Icon(Icons.close, size: 16.sp, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
