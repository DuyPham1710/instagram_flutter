import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/screens/home/widget/post_item.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class PostScreen extends StatelessWidget {
  final List<Post> posts;
  final int selectedPostIndex;
  const PostScreen({
    super.key,
    required this.posts,
    required this.selectedPostIndex,
  });

  @override
  Widget build(BuildContext context) {
    final ItemScrollController itemScrollController = ItemScrollController();
    final postProvider = context.watch<PostProvider>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Posts'),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: ScrollablePositionedList.builder(
          itemScrollController: itemScrollController,
          initialScrollIndex: selectedPostIndex,
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final postId = posts[index].postId;
            final likedPosts = postProvider.likedPosts;
            final savedPosts = postProvider.savedPosts;

            final isLiked = likedPosts.any(
              (likePost) => likePost.post?.postId == postId,
            );

            final isSaved = savedPosts.any(
              (savedPost) => savedPost.post.postId == postId,
            );

            return PostItem(
              posts: posts,
              index: index,
              isLiked: isLiked,
              isSaved: isSaved,
            );
          },
        ),
      ),
    );
  }
}
