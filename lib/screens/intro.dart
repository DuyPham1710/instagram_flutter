import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram_flutter/screens/auth/login_screen.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    super.initState();
    // Chờ 2 giây rồi chuyển sang Login
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 230.h),
            Image.asset(
              'images/icon_instagram.png',
              width: 144.w,
              height: 144.h,
            ),
            SizedBox(height: 230.h),
            Image.asset('images/meta.jpg', width: 160.w, height: 160.h),
          ],
        ),
      ),
    );
  }
}
