import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePostItem extends StatelessWidget {
  const ProfilePostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 120.w,
      child: Image.network(
        'https://i.pinimg.com/736x/3d/54/a3/3d54a3afe927891ec41fec08f2c563d8.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
