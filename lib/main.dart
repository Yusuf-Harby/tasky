import 'package:flutter/material.dart';
import 'package:tasky/animated_splash_screen.dart';
import 'package:tasky/home_screen.dart';
import 'package:tasky/login_screen.dart';
import 'package:tasky/onboarding_screen.dart';
import 'package:tasky/register_screen.dart';

void main (){
  runApp(Tasky());
}
class Tasky extends StatelessWidget {
  const Tasky({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AnimatedSplashScreen.pageRoute,
      routes: {
        AnimatedSplashScreen.pageRoute : (_) => AnimatedSplashScreen(),
        OnboardingScreen.pageRoute : (_) => OnboardingScreen(),
        LoginScreen.pageRoute : (_) => LoginScreen(),
        RegisterScreen.pageRoute : (_) => RegisterScreen(),
        HomeScreen.pageRoute : (_) => HomeScreen(),
      },
    );
  }
}
