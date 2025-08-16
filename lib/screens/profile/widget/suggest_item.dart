import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/toggle_follow_dto.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/providers/Follow_provider.dart';
import 'package:instagram_flutter/screens/profile/user_profile_screen.dart';
import 'package:provider/provider.dart';

class SuggestItem extends StatelessWidget {
  final VoidCallback onClose;
  final UserResponseDto user;

  const SuggestItem({super.key, required this.user, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Consumer<FollowProvider>(
      builder: (context, followProvider, child) {
        final isFollowing = followProvider.following.any(
          (f) => f.following?.userId == user.userId,
        );

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
              border: Border.all(
                color: const Color.fromARGB(255, 243, 243, 243),
              ),
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
                      onPressed: () async {
                        //   if (!isFollowing) {
                        final message = await followProvider.toggleFollow(
                          ToggleFollowDto(followingId: user.userId),
                        );

                        if (message == null) {
                          await followProvider.fetchFollowing();
                        } else {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));
                        }
                        //    }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 34.h),
                        backgroundColor: isFollowing
                            ? Colors.grey
                            : Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      child: Text(
                        isFollowing ? "Following" : "Follow",
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
      },
    );
  }
}
