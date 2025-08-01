import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/toggle_like_dto.dart';
import 'package:instagram_flutter/dto/toggle_save_post_dto.dart';
import 'package:instagram_flutter/models/PostImages.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/screens/home/widget/modal_comment.dart';
import 'package:instagram_flutter/screens/home/widget/modal_like.dart';
import 'package:instagram_flutter/screens/home/widget/modal_more.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostItem extends StatelessWidget {
  final int index;

  PostItem({super.key, required this.index});

  final PageController _pageController = PageController();
  List<PostImages> _imagePaths = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
      builder: (context, postProvider, child) {
        if (postProvider.postsFollowing.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        if (index >= postProvider.postsFollowing.length) {
          return SizedBox.shrink(); // Tránh lỗi khi index vượt quá số lượng bài viết
        }

        _imagePaths = postProvider.postsFollowing[index].images;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 0,
              ),
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
                        image: NetworkImage(
                          postProvider.postsFollowing[index].user?.avatarUrl ??
                              'https://example.com/default_avatar.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                postProvider.postsFollowing[index].user?.username ?? 'Unknown',
              ),
              subtitle: Text(
                timeago.format(postProvider.postsFollowing[index].createdAt),
              ),
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
            _imagePaths.isNotEmpty
                ? SizedBox(
                    height: 500.h,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _imagePaths.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          _imagePaths[index].imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image),
                        );
                      },
                    ),
                  )
                : SizedBox.shrink(),

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
                    onTap: () async {
                      final postId = postProvider.postsFollowing[index].postId;

                      await postProvider.toggleLikePost(
                        ToggleLikeDto(postId: postId),
                      );
                    },
                    child: Icon(
                      postProvider.postsFollowing[index].isLiked == true
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: postProvider.postsFollowing[index].isLiked == true
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return ModalLike(
                            likePost:
                                postProvider.postsFollowing[index].likePost,
                          );
                        },
                      );
                    },
                    child: Text(
                      '${postProvider.postsFollowing[index].likeCount}',
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Icon(CupertinoIcons.chat_bubble),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (BuildContext context) {
                          return ModalComment();
                        },
                      );
                    },
                    child: Text('14'),
                  ),
                  SizedBox(width: 10.w),
                  Icon(CupertinoIcons.paperplane),
                  Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final postId = postProvider.postsFollowing[index].postId;
                      await postProvider.savePost(
                        ToggleSavePostDto(postId: postId),
                      );
                    },
                    child: Icon(
                      postProvider.postsFollowing[index].isSaved == true
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
      },
    );
  }
}
