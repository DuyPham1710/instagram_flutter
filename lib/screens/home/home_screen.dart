import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/screens/home/widget/home_header.dart';
import 'package:instagram_flutter/screens/home/widget/home_stories_widget.dart';
import 'package:instagram_flutter/screens/home/widget/post_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // context.read<PostProvider>().fetchSavedPosts();
    // context.read<PostProvider>().fetchLikedPosts();
    // context.read<PostProvider>().fetchAllPostsFollowing();
    context.read<PostProvider>().initializeHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: postProvider.isReady
            ? ListView(
                children: [
                  HomeHeader(),
                  HomeStoriesWidget(),
                  ListView.builder(
                    physics:
                        NeverScrollableScrollPhysics(), // tránh scroll lồng nhau
                    shrinkWrap: true, // giúp list con chiếm chiều cao vừa đủ
                    itemCount: postProvider.postsFollowing.length,
                    itemBuilder: (context, index) {
                      return PostItem(index: index);
                    },
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
