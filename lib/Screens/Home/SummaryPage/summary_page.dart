import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/Screens/Home/SummaryPage/child_widgets/summary_page_content.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  static const String route = "/SummaryPage";

  SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundContainer(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
            child: SummaryPageContent(
          isKeyboardShowing: Common.instance.isKeyboardShowing(context),
        )),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
