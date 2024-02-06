import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:export_support_customer/Screens/Home/MainService/child_widgets/main_service_body.dart';
import 'package:export_support_customer/Screens/Home/MainService/child_widgets/main_service_header.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';

class MainServicePage extends StatelessWidget {
  final String serviceID;
  final ServiceType serviceType;
  MainServicePage(
      {Key? key, required this.serviceID, required this.serviceType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundContainer(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
          child: MainServicePageContent(
            serviceID: serviceID,
            serviceType: serviceType,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class MainServicePageContent extends StatelessWidget {
  final String serviceID;
  final ServiceType serviceType;
  MainServicePageContent(
      {Key? key, required this.serviceID, required this.serviceType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    bool isArabic = localizations.isArabic();

    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        children: <Widget>[
          MainServiceTypeHeader(
            serviceID: serviceID,
            headerTitle: isArabic
                ? serviceType.optionsTitleAr
                : serviceType.optionsTitleEn,
          ),
          Expanded(
            child: MainServiceBody(
              serviceID: serviceID,
              mainServiceList: serviceType.mainServiceList,
            ),
          )
        ],
      ),
    );
  }
}
