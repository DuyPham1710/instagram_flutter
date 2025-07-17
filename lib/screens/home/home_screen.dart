import 'package:flutter/material.dart';
import 'package:instagram_flutter/screens/home/widget/home_header.dart';
import 'package:instagram_flutter/screens/home/widget/home_stories_widget.dart';
import 'package:instagram_flutter/screens/home/widget/post_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            HomeHeader(),
            HomeStoriesWidget(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(), // tránh scroll lồng nhau
              shrinkWrap: true, // giúp list con chiếm chiều cao vừa đủ
              itemCount: 5,
              itemBuilder: (context, index) {
                return PostItem(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
