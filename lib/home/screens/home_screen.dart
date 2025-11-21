import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/auth/screens/login_screen.dart';
import 'package:tasky/core/network/firebase_result.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_dialog.dart';
import 'package:tasky/home/data/firebase/firebase_task.dart';
import 'package:tasky/home/data/model/task_model.dart';
import 'package:tasky/widgets/show_bottom_sheet_task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String pageRoute = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController taskName = TextEditingController();
  final TextEditingController taskDescription = TextEditingController();
  List<TaskModel> tasks = [];
  List<TaskModel> completedTasks = [];
  bool isLoading = false;
  void getTasks() async {
    isLoading = true;
    final result = await FBTask.getTasks();
    switch (result) {
      case FBSuccess<List<TaskModel>>():
        List<TaskModel> allTasks = result.data ?? [];
        tasks = allTasks.where((task) => task.isCompleted == false).toList();
        completedTasks = tasks
            .where((task) => task.isCompleted == true)
            .toList();
        isLoading = false;
      case FBError<List<TaskModel>>():
        isLoading = false;
        AppDialog.showError(context, error: result.message);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

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
          InkWell(
            onTap: () => {
              FirebaseAuth.instance.signOut(),
              Navigator.of(context).pushReplacementNamed(LoginScreen.pageRoute),
            },
            child: Row(
              children: [
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
              ],
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : tasks.isNotEmpty
          ? _showTasks()
          : _showEmpty(),
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

  Center _showEmpty() {
    return Center(
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
    );
  }

  Column _showTasks() {
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          height: 100.h,
          initialSelectedDate: DateTime.now(),
          selectionColor: AppColor.primary,
          selectedTextColor: AppColor.white,
          daysCount: 30,
          onDateChange: (date) {
            // New date selected
          },
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskItem(
                title: tasks[index].title ?? 'Untitled Task',
                time: tasks[index].date.toString(),
                priority: tasks[index].priority ?? 1,
                isCompleted: tasks[index].isCompleted ?? false,
              );
            },
          ),
        ),
      ],
    );
  }

  void _addTask() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ShowBottomSheetTask(),
    );
  }
}

class TaskItem extends StatelessWidget {
  final String title;
  final String time;
  final int priority;
  final bool isCompleted;

  const TaskItem({
    super.key,
    required this.title,
    required this.time,
    required this.priority,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.r),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.3),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CheckCircle(isCompleted: isCompleted),
          SizedBox(width: 18.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 1.h),
              Text(
                time,
                style: TextStyle(fontSize: 14, color: AppColor.grayText),
              ),
            ],
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.all(5.r),
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              border: BoxBorder.all(color: AppColor.primary),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5.w,
              children: [
                SvgPicture.asset(
                  'assets/icons/flag.svg',
                  width: 24.w,
                  height: 24.w,
                  fit: BoxFit.contain,
                ),
                Text(
                  '$priority',
                  style: TextStyle(
                    color: AppColor.title,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckCircle extends StatefulWidget {
  CheckCircle({super.key, required this.isCompleted});
  bool isCompleted;
  @override
  State<CheckCircle> createState() => _CheckCircleState();
}

class _CheckCircleState extends State<CheckCircle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isCompleted = !widget.isCompleted;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.primary, width: 2),
        ),
        child: widget.isCompleted
            ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.primary,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
