import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/validator.dart';
import 'package:tasky/widgets/custom_text_form_field_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String pageRoute = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController taskName = TextEditingController();
  final TextEditingController taskDescription = TextEditingController();
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
          onPressed: _addTask,
          backgroundColor: AppColor.title,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: AppColor.primary),
        ),
      ),
    );
  }

  void _addTask() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        height: 270.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            Text(
              'Add Task',
              style: TextStyle(
                color: AppColor.title,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14.h),
            TextFormFieldWidget(
              controller: taskName,
              hintText: 'Do Flutter project',
              validator: Validator.validateName,
            ),
            SizedBox(height: 12.h),
            TextFormFieldWidget(
              controller: taskDescription,
              hintText: 'Description',
              validator: Validator.validateName,
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/date.svg',
                  width: 24.w,
                  height: 24.w,
                ),
                SizedBox(width: 10.w),
                SvgPicture.asset(
                  'assets/icons/flag.svg',
                  width: 24.w,
                  height: 24.w,
                ),
                Spacer(),
                SvgPicture.asset(
                  'assets/icons/send.svg',
                  width: 24.w,
                  height: 24.w,
                ),
              ],
            ),
            SizedBox(height: 17.h),
          ],
        ),
      ),
    );
  }
}
