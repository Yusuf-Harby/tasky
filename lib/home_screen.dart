import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String pageRoute = 'Home Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          'assets/images/logo/logo.svg',
          width: 78.22.w,
          height: 28.39.h,
        ),
        actions: [
          SvgPicture.asset(
            'assets/icons/logout.svg',
            width: 24.w,
            height: 24.w,
          ),
          SizedBox(width: 10.w),
          Text(
            'Log out',
            style: TextStyle(
              color: AppColor.red,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 85.h),
            Image.asset(
              'assets/images/empty_home_image.png',
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: 15.h),
            Text(
              'What do you want to do today?',
              style: TextStyle(
                color: AppColor.title,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Tap + to add your tasks',
              style: TextStyle(
                color: AppColor.title,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60.w,
        height: 60.w,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColor.title,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: AppColor.primary),
        ),
      ),
    );
  }
}
