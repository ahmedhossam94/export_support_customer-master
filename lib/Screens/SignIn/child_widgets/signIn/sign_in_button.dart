import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  SignInButton({Key? key, required this.title, required this.onPressed});

  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
                fontSize: Screen.fontSize(size: 20), color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColor.darkRed),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ));
  }
}
