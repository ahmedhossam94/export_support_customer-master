import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  CommonButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
            width: double.infinity,
            height: Screen.screenWidth * 0.13,
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(
                title,
                style: TextStyle(fontSize: Screen.fontSize(size: 22)),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(AppColor.darkRed),
                textStyle: MaterialStatePropertyAll(TextStyle(
                  color: Colors.white,
                )),
              ),
            )));
  }
}
