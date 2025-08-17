import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/apps/utils/image_util.dart';
import 'package:instagram_flutter/screens/profile/widget/photo_picker_screen.dart';

class ModalCreate extends StatefulWidget {
  ModalCreate({super.key});

  @override
  State<ModalCreate> createState() => _ModalCreateState();
}

class _ModalCreateState extends State<ModalCreate> {
  final items = [
    {"icon": CupertinoIcons.play_rectangle, "label": "Reel"},
    {"icon": CupertinoIcons.square_grid_2x2, "label": "Post"},
    {"icon": CupertinoIcons.add_circled, "label": "Story"},
    {"icon": CupertinoIcons.heart_circle, "label": "Story highlight"},
    {"icon": CupertinoIcons.dot_radiowaves_left_right, "label": "Live"},
  ];

  List<XFile> _images = [];

  Future<void> _onPickImage() async {
    final files = await ImageUtil.pickImages();
    if (files != null) {
      // print("Selected images: ${files.length}");
      setState(() {
        _images = files;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      maxChildSize: 0.5,
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
                'Create',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),

              SizedBox(height: 14.h),
              Divider(height: 1.h, color: Colors.grey[300]),

              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1.h,
                    color: Colors.grey[300],
                    indent: 20.w,
                    endIndent: 20.w,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return InkWell(
                      onTap: () async {
                        if (item["label"] == "Post") {
                          //  _onPickImage();
                          final selectedImages = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PhotoPickerScreen(),
                            ),
                          );

                          if (selectedImages != null) {
                            print(
                              "User selected ${selectedImages.length} images",
                            );
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        child: Row(
                          children: [
                            Icon(item["icon"] as IconData, size: 24.h),
                            SizedBox(width: 20.w),
                            Text(
                              item["label"].toString(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
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
