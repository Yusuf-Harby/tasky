import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/utils/app_colors.dart';

class PriorityDialogWidget extends StatefulWidget {
  const PriorityDialogWidget({super.key, required this.onTap});
  final void Function(int) onTap;
  @override
  State<PriorityDialogWidget> createState() => _PriorityDialogWidgetState();
}

class _PriorityDialogWidgetState extends State<PriorityDialogWidget> {
  List<int> priority = List.generate(10, (index) => index + 1);
  int selectedItem = 1;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(
            'Task Priority',
            style: TextStyle(
              color: AppColor.title,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: AppColor.grayText),
        ],
      ),
      content: Wrap(
        children: priority
            .map(
              (index) => PriorityItemWidget(
                index: index,
                isSelected: index == selectedItem,
                onTap: () {
                  selectedItem = index;
                  widget.onTap(index);
                  setState(() {});
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class PriorityItemWidget extends StatelessWidget {
  const PriorityItemWidget({
    super.key,
    this.onTap,
    required this.index,
    required this.isSelected,
  });
  final void Function()? onTap;
  final int index;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5.r),
        padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          border: isSelected ? null : BoxBorder.all(color: AppColor.grayText),
          color: isSelected ? AppColor.primary : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 7.h,
          children: [
            SvgPicture.asset(
              'assets/icons/flag.svg',
              width: 24.w,
              height: 24.w,
              fit: BoxFit.contain,
              color: isSelected ? AppColor.white : null,
            ),
            Text(
              index.toString(),
              style: TextStyle(
                color: isSelected ? AppColor.white : AppColor.title,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
