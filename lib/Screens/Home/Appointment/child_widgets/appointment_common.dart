import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:flutter/material.dart';

class AppointmentCommon extends StatelessWidget {
  AppointmentCommon(
      {Key? key,
      required this.text,
      required this.buttonTitle,
      required this.onPressed})
      : super(key: key);

  final String text;
  final String buttonTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        ElevatedButton(
            onPressed: onPressed,
            child: Text(
              buttonTitle,
              style: TextStyle(fontSize: Screen.fontSize(size: 16)),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColor.darkRed),
              textStyle:
                  MaterialStatePropertyAll(TextStyle(color: Colors.white)),
              padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
            )),
        text != null
            ? Column(
                children: <Widget>[
                  Container(
                    height: 8,
                  ),
                  Container(
                      child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: Screen.fontSize(size: 22),
                        color: AppColor.lightGray),
                  )),
                ],
              )
            : Container(),
      ]),
    );
  }
}
