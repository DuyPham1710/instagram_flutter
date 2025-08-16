import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/Follow_provider.dart';
import 'package:instagram_flutter/providers/post_provider.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_actions.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_header.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_info.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_story.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_suggest.dart';
import 'package:instagram_flutter/screens/profile/widget/profile_tabs.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  final ValueNotifier<bool> isShowSuggest = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    context.read<PostProvider>().fetchAllPosts();
    context.read<FollowProvider>().fetchFollowers();
    context.read<FollowProvider>().fetchFollowing();
  }

  @override
  void dispose() {
    isShowSuggest.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            ProfileHeader(),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return ProfileInfo(user: userProvider.user);
              },
            ),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return ProfileActions(
                  toggleSuggest: () {
                    isShowSuggest.value = !isShowSuggest.value;
                  },
                  isShowSuggest: isShowSuggest,
                  user: userProvider.user,
                );
              },
            ),

            ValueListenableBuilder<bool>(
              valueListenable: isShowSuggest,
              builder: (context, show, _) {
                return show ? ProfileSuggest() : SizedBox.shrink();
              },
            ),
            ProfileStory(),
            IntrinsicHeight(
              child: ProfileTabs(posts: context.watch<PostProvider>().posts),
            ),
          ],
        ),
      ),
    );
  }
}
