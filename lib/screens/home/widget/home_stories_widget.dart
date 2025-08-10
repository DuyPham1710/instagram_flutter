import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/screens/home/widget/story_item.dart';
import 'package:provider/provider.dart';

class HomeStoriesWidget extends StatelessWidget {
  const HomeStoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserProvider>().fetchAllUsersOther(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.black));
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'Error fetching user data',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        }

        final users = snapshot.data;

        return SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return StoryItem(user: users[index], index: index);
            },
          ),
        );
      },
    );
  }
}
