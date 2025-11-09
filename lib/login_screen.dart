import 'package:flutter/material.dart';

import 'app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String pageRoute = 'Login Screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.title,
    );
  }
}
