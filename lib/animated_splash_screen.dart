import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tasky/app_colors.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});
  static const String pageRoute = 'Animated Splash Screen';
  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 4),
        (){
          Navigator.of(context).pushReplacementNamed('Onboarding Screen');
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 2,
          children: [
            FadeInLeft(
              delay: Duration(milliseconds: 2000),
              duration: Duration(milliseconds: 500),
              child: Image.asset('assets/images/logo/Task_logo.png'),
            ),
            BounceInDown(
              delay: Duration(milliseconds: 2500),
              child: Transform.translate(
                offset: const Offset(0, 10),
                child: Image.asset('assets/images/logo/y_logo.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
