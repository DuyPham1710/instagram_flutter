import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileActions extends StatefulWidget {
  const ProfileActions({super.key});

  @override
  State<ProfileActions> createState() => _ProfileActionsState();
}

class _ProfileActionsState extends State<ProfileActions> {
  bool isShowSuggest = true;

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
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => showToast("Bạn đã ấn nút Edit Profile!"),
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
          Container(
            alignment: Alignment.center,
            height: 36.h,
            width: 36.w,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  isShowSuggest = !isShowSuggest;
                });
              },
              child: Icon(
                isShowSuggest
                    ? CupertinoIcons.person_add_solid
                    : CupertinoIcons.person_add,
                // CupertinoIcons.person_add_solid,
                size: 22.h,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
