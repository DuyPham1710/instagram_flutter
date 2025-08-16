import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/screens/profile/widget/edit_profile.dart';

class ProfileActions extends StatelessWidget {
  final VoidCallback toggleSuggest;
  final ValueNotifier<bool> isShowSuggest;
  final UserResponseDto? user;

  const ProfileActions({
    super.key,
    required this.toggleSuggest,
    required this.isShowSuggest,
    required this.user,
  });

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 12.sp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        EditProfile(user: user),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0); // từ dưới
                          const end = Offset.zero; // đến vị trí gốc
                          const curve = Curves.ease;

                          final tween = Tween(
                            begin: begin,
                            end: end,
                          ).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 36.h,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: InkWell(
              onTap: () => showToast("Bạn đã ấn nút Share Profile!"),
              child: Container(
                alignment: Alignment.center,
                height: 36.h,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  "Share Profile",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          ValueListenableBuilder<bool>(
            valueListenable: isShowSuggest,
            builder: (context, show, _) {
              return Container(
                alignment: Alignment.center,
                height: 36.h,
                width: 36.w,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: InkWell(
                  onTap: toggleSuggest,
                  child: Icon(
                    show
                        ? CupertinoIcons.person_add_solid
                        : CupertinoIcons.person_add,
                    size: 22.h,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
