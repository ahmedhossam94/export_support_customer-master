import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:export_support_customer/Screens/Home/ServiceType/child_widgets/service_type_body.dart';
import 'package:export_support_customer/Screens/Home/ServiceType/child_widgets/service_type_header.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';

class ServiceTypePage extends StatelessWidget {
  static const String route = "/ServiceTypePage";
  final ServiceCatagory serviceCatagory;
  ServiceTypePage({Key? key, required this.serviceCatagory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundContainer(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
          child: ServiceTypePageContent(serviceCatagory: serviceCatagory),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class ServiceTypePageContent extends StatelessWidget {
  final ServiceCatagory serviceCatagory;
  ServiceTypePageContent({Key? key, required this.serviceCatagory})
      : super(key: key);

  String _getServiceCategoryName(AppLocalizations localizations) {
    return localizations.isArabic()
        ? serviceCatagory.nameAr
        : serviceCatagory.nameEn;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      child: Column(
        children: <Widget>[
          ServiceTypeHeader(
            serviceID: serviceCatagory.id,
            serviceName: _getServiceCategoryName(localizations),
          ),
          Expanded(
              child: ServiceTypeBody(
            serviceID: serviceCatagory.id,
            serviceTypes: serviceCatagory.serviceTypeList,
          ))
        ],
      ),
    );
  }
}
