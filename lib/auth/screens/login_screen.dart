import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/custom_text_form_field_widget.dart';
import 'package:tasky/home_screen.dart';
import 'package:tasky/auth/screens/register_screen.dart';
import 'package:tasky/auth/widgets/register_widget.dart';
import 'package:tasky/utils/app_dialog.dart';
import 'package:tasky/utils/validator.dart';
import '../../app_colors.dart';

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
  Future<void> login({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw 'incorrect email or password';
    }
  }

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
              SizedBox(height: 112 / 812 * size.height),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 32 / 375 * size.width,
                    fontWeight: FontWeight.bold,
                    color: AppColor.title,
                  ),
                ),
              ),
              SizedBox(height: 53 / 812 * size.height),
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
              SizedBox(height: 26 / 812 * size.height),
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
              SizedBox(height: 71 / 812 * size.height),
              MaterialButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    AppDialog.showLoading(context, size);
                    login(email: email.text, password: password.text)
                        .then((value) {
                          Navigator.of(context).pop();
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(HomeScreen.pageRoute);
                        })
                        .catchError((error) {
                          Navigator.of(context).pop();
                          AppDialog.showError(
                            context,
                            size,
                            error: error.toString(),
                          );
                        });
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
                    'Login',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16 / 375 * size.width,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 246 / 812 * size.height),
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
}
