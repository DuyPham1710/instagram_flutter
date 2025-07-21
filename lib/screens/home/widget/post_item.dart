import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/screens/home/widget/modal_more.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PostItem extends StatefulWidget {
  final int index;
  const PostItem({super.key, required this.index});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool isLiked = false;
  bool isSaved = false;
  final PageController _pageController = PageController();
  final List<String> _imagePaths = [
    'images/post_1.jpg',
    'images/post_2.jpg',
    'images/post_3.jpg',
    'images/post_4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0),
          leading: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
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
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 2.h),
                  image: DecorationImage(
                    image: AssetImage('images/avt.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          title: Text('User ${widget.index}'),
          subtitle: Text('2 hours ago'),
          trailing: InkWell(
            onTap: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ModalMore();
                },
              );
            },
            child: Icon(CupertinoIcons.ellipsis),
          ),
        ),

        // PageView ảnh
        SizedBox(
          height: 500.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _imagePaths.length,
            itemBuilder: (context, index) {
              return Image.asset(
                _imagePaths[index],
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
        ),

        // Indicator
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: _imagePaths.length,
              effect: ScrollingDotsEffect(
                activeDotColor: Colors.blueAccent,
                dotColor: const Color.fromARGB(255, 233, 233, 233),
                dotHeight: 6.h,
                dotWidth: 6.w,
                spacing: 4.w,
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                child: Icon(
                  isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                  color: isLiked ? Colors.red : Colors.black,
                ),
              ),
              SizedBox(width: 10.w),
              Icon(CupertinoIcons.chat_bubble),
              SizedBox(width: 10.w),
              Icon(CupertinoIcons.paperplane),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSaved = !isSaved;
                  });
                },
                child: Icon(
                  isSaved
                      ? CupertinoIcons.bookmark_fill
                      : CupertinoIcons.bookmark,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text('Liked by user123 and others'),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
