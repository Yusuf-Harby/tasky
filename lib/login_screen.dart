import 'package:flutter/material.dart';
import 'package:tasky/custom_text_form_field_widget.dart';
import 'package:tasky/register_widget.dart';
import 'app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String pageRoute = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 112),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColor.title,
                ),
              ),
            ),
            SizedBox(height: 53),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.title,
                ),
              ),
            ),
            SizedBox(height: 5),
            TextFormFieldWidget(
              controller: email,
              validator: validator,
              hintText: 'enter email',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 26),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.title,
                ),
              ),
            ),
            SizedBox(height: 5),
            TextFormFieldWidget(
              controller: password,
              validator: validator,
              hintText: 'Password',
              isPassword: true,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            SizedBox(height: 71),
            MaterialButton(
              onPressed: () {},
              color: AppColor.primary,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Spacer(),
            RegisterWidget(
              question: "Don't have an account? ",
              action: 'Register',
              onTap: () {},
            ),
            SizedBox(height: 33),
          ],
        ),
      ),
    );
  }
}
