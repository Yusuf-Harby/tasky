import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasky/animated_splash_screen.dart';
import 'package:tasky/firebase_options.dart';
import 'package:tasky/home_screen.dart';
import 'package:tasky/auth/screens/login_screen.dart';
import 'package:tasky/onboarding_screen.dart';
import 'package:tasky/auth/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        AnimatedSplashScreen.pageRoute: (_) => AnimatedSplashScreen(),
        OnboardingScreen.pageRoute: (_) => OnboardingScreen(),
        LoginScreen.pageRoute: (_) => LoginScreen(),
        RegisterScreen.pageRoute: (_) => RegisterScreen(),
        HomeScreen.pageRoute: (_) => HomeScreen(),
      },
    );
  }
}
