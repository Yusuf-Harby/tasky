import 'package:flutter/material.dart';
import 'package:tasky/animated_splash_screen.dart';
import 'package:tasky/onboarding_screen.dart';

void main (){
  runApp(Tasky());
}
class Tasky extends StatelessWidget {
  const Tasky({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'Animated Splash Screen',
      routes: {
        'Animated Splash Screen' : (context) => AnimatedSplashScreen(),
        'Onboarding Screen' : (context) => OnboardingScreen(),
      },
    );
  }
}
