import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/models/Like.dart';

class ModalLike extends StatelessWidget {
  final List<Like> likePost;
  const ModalLike({super.key, required this.likePost});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              SizedBox(height: 14.h),

              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              SizedBox(height: 10.h),

              Text(
                'Lượt thích',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    filled: true,
                    fillColor: Colors.grey[200],
                    prefixIcon: Icon(CupertinoIcons.search),
                    prefixIconColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 12.w,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: likePost.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30.r,
                        backgroundImage: NetworkImage(
                          likePost[index].user.avatarUrl ??
                              'https://i.pinimg.com/736x/8b/28/8d/8b288dbd8cb07d0f85adc8bdd7006ecc.jpg',
                        ),
                      ),
                      title: Text(
                        likePost[index].user.fullName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                      subtitle: Text(
                        likePost[index].user.username,
                        style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // TODO: Follow logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text('Theo dõi'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
