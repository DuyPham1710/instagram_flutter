import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModalMore extends StatelessWidget {
  const ModalMore({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        // height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.bookmark, color: Colors.black),
                      SizedBox(height: 5.h),
                      Text(
                        'Save',
                        style: TextStyle(color: Colors.black, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.qrcode, color: Colors.black),
                      SizedBox(height: 5.h),
                      Text(
                        'QR Code',
                        style: TextStyle(color: Colors.black, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.star, color: Colors.black),
                      SizedBox(width: 5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'Add to favorites',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.person_badge_minus,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'Unfollow',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.person_circle, color: Colors.black),
                      SizedBox(width: 5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'About this account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Icon(CupertinoIcons.info_circle, color: Colors.black),
                      SizedBox(width: 5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'Information',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Icon(CupertinoIcons.eye_slash, color: Colors.black),
                      SizedBox(width: 5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'Hide',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.exclamationmark_triangle,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          'Report',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
