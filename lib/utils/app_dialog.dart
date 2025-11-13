import 'package:flutter/material.dart';
import 'package:tasky/app_colors.dart';

abstract class AppDialog {
  static void showLoading(BuildContext context, Size size) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(color: AppColor.primary),
              SizedBox(width: 20 / 375 * size.width),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16 / 375 * size.width,
                  fontWeight: FontWeight.w500,
                  color: AppColor.title,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showError(
    BuildContext context,
    Size size, {
    required String error,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text('Error'),
          content: Text(error),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
