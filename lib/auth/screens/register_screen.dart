import 'package:flutter/material.dart';
import 'package:tasky/custom_text_form_field_widget.dart';
import 'package:tasky/auth/widgets/register_widget.dart';
import 'package:tasky/utils/validator.dart';
import '../../app_colors.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24 / 375 * size.width),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 97 / 812 * size.height),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 32 / 375 * size.width,
                    fontWeight: FontWeight.bold,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 23 / 812 * size.height),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 16 / 375 * size.width,
                    fontWeight: FontWeight.w400,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 5 / 812 * size.height),
              TextFormFieldWidget(
                controller: username,
                validator: Validator.validateName,
                hintText: 'enter username',
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 11 / 812 * size.height),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16 / 375 * size.width,
                    fontWeight: FontWeight.w400,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 5 / 812 * size.height),
              TextFormFieldWidget(
                controller: email,
                validator: Validator.validateEmail,
                hintText: 'enter email',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 11 / 812 * size.height),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16 / 375 * size.width,
                    fontWeight: FontWeight.w400,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 5 / 812 * size.height),
              TextFormFieldWidget(
                controller: password,
                validator: Validator.validatePassword,
                hintText: 'Password',
                isPassword: true,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 11 / 812 * size.height),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Confirm Password',
                  style: TextStyle(
                    fontSize: 16 / 375 * size.width,
                    fontWeight: FontWeight.w400,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 5 / 812 * size.height),
              TextFormFieldWidget(
                controller: confirmPassword,
                validator: (val) =>
                    Validator.validateConfirmPassword(val, password.text),
                hintText: 'Password',
                isPassword: true,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 76 / 812 * size.height),
              MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
                color: AppColor.primary,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10 / 375 * size.width),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12 / 812 * size.height,
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16 / 375 * size.width,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 112 / 812 * size.height),
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
}
