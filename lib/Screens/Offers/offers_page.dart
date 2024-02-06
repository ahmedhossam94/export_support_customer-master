import 'package:export_support_customer/Screens/Offers/child_widgets/offers_page_content.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  static const String route = "/OffersPage";

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(),
        body: SafeArea(child: OffersPageContent()),
      ),
    );
  }
}