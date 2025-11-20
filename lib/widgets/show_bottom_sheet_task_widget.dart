import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/validator.dart';
import 'package:tasky/widgets/custom_text_form_field_widget.dart';

class ShowBottomSheetTask extends StatefulWidget {
  const ShowBottomSheetTask({super.key});

  @override
  State<ShowBottomSheetTask> createState() => _ShowBottomSheetTaskState();
}

class _ShowBottomSheetTaskState extends State<ShowBottomSheetTask> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: MediaQuery.of(context).viewInsets.bottom,
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
              _iconAction('assets/icons/date.svg', () async {
                selectedDate =
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    ) ??
                    DateTime.now();
              }),
              SizedBox(width: 10.w),
              _iconAction('assets/icons/flag.svg', () {}),
              const Spacer(),
              _iconAction('assets/icons/send.svg', () {}),
            ],
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }

  Widget _iconAction(String image, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(image, width: 24.w, height: 24.w),
    );
  }

  late TextEditingController taskName;
  late TextEditingController taskDescription;
  late DateTime selectedDate;
  @override
  void initState() {
    super.initState();
    taskName = TextEditingController();
    taskDescription = TextEditingController();
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
    taskName.dispose();
    taskDescription.dispose();
  }
}
