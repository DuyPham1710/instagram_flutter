import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/screens/profile/widget/suggest_item.dart';
import 'package:provider/provider.dart';

class ProfileSuggest extends StatefulWidget {
  const ProfileSuggest({super.key});

  @override
  State<ProfileSuggest> createState() => ProfileSuggestState();
}

class ProfileSuggestState extends State<ProfileSuggest> {
  late Future<List<UserResponseDto>> _futureUsersOther;

  @override
  void initState() {
    super.initState();
    _futureUsersOther = context.read<UserProvider>().fetchAllUsersOther();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: FutureBuilder(
        future: _futureUsersOther,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'Error fetching user data',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }

          List<UserResponseDto> usersOther =
              snapshot.data as List<UserResponseDto>;

          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            color: Colors.transparent,
            width: double.infinity,
            height: 312.h,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discover People',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: usersOther.length,
                    itemBuilder: (context, index) {
                      return SuggestItem(
                        user: usersOther[index],
                        onClose: () {
                          // Handle close action
                          print('Close item $index');
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
