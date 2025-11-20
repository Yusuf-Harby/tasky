// ignore_for_file: use_build_context_synchronously, unused_local_variable, unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/auth/data/firebase/firebase_database_user.dart';
import 'package:tasky/core/network/firebase_result.dart';
import 'package:tasky/widgets/custom_text_form_field_widget.dart';
import 'package:tasky/home/screens/home_screen.dart';
import 'package:tasky/auth/screens/register_screen.dart';
import 'package:tasky/auth/widgets/register_widget.dart';
import 'package:tasky/core/utils/app_dialog.dart';
import 'package:tasky/core/utils/validator.dart';
import '../../core/utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String pageRoute = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 112.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 53.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              TextFormFieldWidget(
                controller: email,
                validator: Validator.validateEmail,
                hintText: 'enter email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 26.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              TextFormFieldWidget(
                controller: password,
                validator: Validator.validatePassword,
                hintText: 'Password',
                isPassword: true,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 71.h),
              MaterialButton(
                onPressed: _login,
                color: AppColor.primary,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 246.h),
              RegisterWidget(
                question: "Don't have an account? ",
                action: 'Register',
                onTap: () {
                  Navigator.of(context).pushNamed(RegisterScreen.pageRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      AppDialog.showLoading(context);
      final result = await FBAUser.loginUser(
        email: email.text,
        password: password.text,
      );
      switch (result) {
        case FBSuccess<UserCredential>():
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed(HomeScreen.pageRoute);
        case FBError<UserCredential>():
          Navigator.of(context).pop();
          AppDialog.showError(context, error: result.message.toString());
      }
    }
  }
}
