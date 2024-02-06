import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/day_time.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:flutter/material.dart';

class AppointmentVisitTimeRadio extends StatelessWidget {
  AppointmentVisitTimeRadio(
      {Key? key, this.onVisitTimeChange, this.value, this.visitTime})
      : super(key: key);

  final String? value;
  final String? visitTime;
  final Function(String?)? onVisitTimeChange;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.white),
      child: Row(children: <Widget>[
        Radio<String>(
          value: value ?? '',
          groupValue: visitTime,
          onChanged: onVisitTimeChange,
          activeColor: AppColor.yellow,
        ),
        Text(
          DayTime().getDisplayStatus(dayTime: value ?? '', context: context),
          style: TextStyle(
              fontSize: Screen.fontSize(size: 20), color: Colors.white),
        ),
      ]),
    );
  }
}
