import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/auth/data/firebase/firebase_database_user.dart';
import 'package:tasky/core/network/firebase_result.dart';
import 'package:tasky/auth/data/model/user_model.dart';
import 'package:tasky/widgets/custom_text_form_field_widget.dart';
import 'package:tasky/auth/widgets/register_widget.dart';
import 'package:tasky/core/utils/app_dialog.dart';
import 'package:tasky/core/utils/validator.dart';
import '../../core/utils/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const String pageRoute = 'Register Screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
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
              SizedBox(height: 97.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 23.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              TextFormFieldWidget(
                controller: username,
                validator: Validator.validateName,
                hintText: 'enter username',
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 11.h),
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
              SizedBox(height: 11.h),
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
              SizedBox(height: 11.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 16.w,
                    fontWeight: FontWeight.w400,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              TextFormFieldWidget(
                controller: confirmPassword,
                validator: (val) =>
                    Validator.validateConfirmPassword(val, password.text),
                hintText: 'Password',
                isPassword: true,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 76.h),
              MaterialButton(
                onPressed: register,
                color: AppColor.primary,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 112.h),
              RegisterWidget(
                question: "Already have an account? ",
                action: 'Login',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      AppDialog.showLoading(context);
      final result = await FBAUser.registerUser(
        UserModel(
          name: username.text,
          email: email.text,
          password: password.text,
        ),
      );

      switch (result) {
        case FBSuccess<UserModel>():
          Navigator.of(context).pop();
          username.clear();
          email.clear();
          password.clear();
          confirmPassword.clear();
          Navigator.of(context).pop();
        case FBError<UserModel>():
          Navigator.of(context).pop();
          AppDialog.showError(context, error: result.message.toString());
      }
    }
  }
}
