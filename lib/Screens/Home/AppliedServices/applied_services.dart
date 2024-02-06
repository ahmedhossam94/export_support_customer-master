import 'package:export_support_customer/Screens/Home/AppliedServices/child_widgets/applied_service_content.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';

class AppliedServices extends StatelessWidget {
  static const String route = "/AppliedServices";

  AppliedServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundContainer(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(child: AppliedServicesContent()),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
