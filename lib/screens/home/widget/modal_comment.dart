import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/create_comment_dto.dart';
import 'package:instagram_flutter/models/Comment.dart';
import 'package:instagram_flutter/providers/comment_provider.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ModalComment extends StatefulWidget {
  final int postId;
  final List<Comment> comments;

  const ModalComment({super.key, required this.postId, required this.comments});

  @override
  State<ModalComment> createState() => _ModalCommentState();
}

class _ModalCommentState extends State<ModalComment> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    // Focus sau frame đầu tiên
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
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
                'Comments',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),

              SizedBox(height: 14.h),
              Divider(height: 1.h, color: Colors.grey[300]),

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.comments.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(12.w, 12.h, 4.w, 16.h),

                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundImage: NetworkImage(
                              widget.comments[index].user.avatarUrl ??
                                  'https://i.pinimg.com/736x/8b/28/8d/8b288dbd8cb07d0f85adc8bdd7006ecc.jpg',
                            ),
                          ),

                          SizedBox(width: 10.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.comments[index].user.username,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                Text(
                                  widget.comments[index].content,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                Row(
                                  children: [
                                    Text(
                                      'Reply',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(width: 14.w),

                                    Text(
                                      'See translation',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  CupertinoIcons.heart,
                                  size: 20.sp,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  // Handle like action
                                },
                              ),

                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Divider(height: 1.h, color: Colors.grey[300]),
              _buildCommentInput(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentInput(BuildContext context) {
    final userProfile = context.watch<UserProvider>().user;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(
          context,
        ).viewInsets.bottom, // đẩy lên khi bàn phím mở
        left: 16.w,
        right: 10.w,
        top: 8.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundImage: NetworkImage(
              userProfile?.avatarUrl ??
                  'https://i.pinimg.com/736x/8b/28/8d/8b288dbd8cb07d0f85adc8bdd7006ecc.jpg',
            ),
          ),
          SizedBox(width: 10.w),

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(color: Colors.transparent),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'What do you think of this?',
                  border: InputBorder.none,
                ),
                minLines: 1,
                maxLines: 5,
              ),
            ),
          ),

          SizedBox(width: 6.w),

          IconButton(
            icon: Icon(
              CupertinoIcons.arrow_up_circle_fill,
              color: Colors.blueAccent,
            ),
            onPressed: () async {
              if (_controller.text.isNotEmpty) {
                final commentProvider = context.read<CommentProvider>();
                final postProvider = context.read<PostProvider>();

                final newComment = await commentProvider.createComment(
                  CreateCommentDto(
                    content: _controller.text,
                    postId: widget.postId,
                  ),
                );

                if (newComment == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to create comment')),
                  );
                  return;
                }
                postProvider.addCommentByPostId(widget.postId, newComment);

                // Clear the input field
                _controller.clear();
                _focusNode.unfocus();
              }
            },
          ),
        ],
      ),
    );
  }
}
