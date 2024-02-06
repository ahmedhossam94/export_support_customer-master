import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/Screens/Home/Appointment/child_widgets/appointment_page_content.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  static const String route = "/AppointmentPage";

  AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundContainer(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
            child: AppointmentPageContent(
          isKeyboardShowing: Common.instance.isKeyboardShowing(context),
        )),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
