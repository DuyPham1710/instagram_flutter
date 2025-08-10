import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/models/Post.dart';
import 'package:instagram_flutter/screens/post/post_screen.dart';

class ProfilePostItem extends StatelessWidget {
  final Post? post;
  final List<Post> posts;
  const ProfilePostItem({super.key, required this.post, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        int selectedIndex = posts.indexWhere((p) => p.postId == post!.postId);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PostScreen(posts: posts, selectedPostIndex: selectedIndex),
          ),
        );
      },
      child: SizedBox(
        width: 100.w,
        height: 120.w,
        child: Image.network(
          post?.images[0].imageUrl ?? '',
          //   'https://i.pinimg.com/736x/3d/54/a3/3d54a3afe927891ec41fec08f2c563d8.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
