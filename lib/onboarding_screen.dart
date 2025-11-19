import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky/auth/screens/login_screen.dart';
import 'app_colors.dart';
import 'custom_animated_widget.dart';
import 'onboarding_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String pageRoute = 'Onboarding Screen';
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingData> onboarding = onboardingData();
  int index = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(
              height: 240.h,
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    this.index = index;
                  });
                },
                itemCount: onboarding.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CustomAnimatedWidget(
                    delay: index,
                    index: index,
                    child: Image.asset(onboarding[index].image),
                  );
                },
              ),
            ),
            SizedBox(height: 30.h),
            SmoothPageIndicator(
              controller: controller,
              count: onboarding.length,
              effect: ExpandingDotsEffect(
                dotHeight: 4.h,
                dotWidth: 26.w,
                radius: 56.r,
                dotColor: AppColor.gray,
                activeDotColor: AppColor.primary,
                strokeWidth: 0,
                expansionFactor: 1.1.w,
              ),
            ),
            SizedBox(height: 50.h),
            CustomAnimatedWidget(
              delay: index * 2 + 500,
              index: index + 1,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Text(
                      onboarding[index].title,
                      style: TextStyle(
                        color: AppColor.title,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 42.h),
                    Text(
                      onboarding[index].description,
                      style: TextStyle(
                        color: AppColor.grayText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                onPressed: () {
                  if (index < onboarding.length - 1) {
                    controller.nextPage(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                    );
                  } else {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(LoginScreen.pageRoute);
                  }
                },
                color: AppColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  child: Text(
                    index == onboarding.length - 1 ? 'GET STARTED' : 'NEXT',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 62.h),
          ],
        ),
      ),
    );
  }
}

List<OnboardingData> onboardingData() {
  return [
    OnboardingData(
      title: 'Manage your tasks',
      description:
          'You can easily manage all of your daily tasks in DoMe for free',
      image: 'assets/images/onboarding/onboarding_image1.png',
    ),
    OnboardingData(
      title: 'Create daily routine',
      description:
          'In Tasky  you can create your personalized routine to stay productive',
      image: 'assets/images/onboarding/onboarding_image2.png',
    ),
    OnboardingData(
      title: 'Orgonaize your tasks',
      description:
          'You can organize your daily tasks by adding your tasks into separate categories',
      image: 'assets/images/onboarding/onboarding_image3.png',
    ),
  ];
}
