import 'dart:io';

import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Models/general_details.dart';
import 'package:export_support_customer/Models/service_type_action.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:export_support_customer/Screens/Home/MainService/main_service.dart';
import 'package:export_support_customer/Screens/Home/ServiceType/child_widgets/service_type_body_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceTypeBody extends StatelessWidget {
  final String serviceID;
  final List<ServiceType> serviceTypes;
  ServiceTypeBody(
      {Key? key, required this.serviceID, required this.serviceTypes})
      : super(key: key);

  _onServiceTypeTapped(BuildContext context, int index) {
    ServiceType serviceType = serviceTypes[index];
    if (serviceType.hasMainService) {
      Common.instance.notavigateTo(
          page: MainServicePage(
            serviceID: serviceID,
            serviceType: serviceType,
          ),
          pageName: "MainServicePage",
          context: context);
    } else {
      bool isArabic = AppLocalizations.of(context).isArabic();

      if (serviceType.action == ServiceTypeAction.contactTechViaWhatsapp) {
        Common.instance.showContactTechViaWhatsApp(
            context: context,
            title: isArabic ? serviceType.nameAr : serviceType.nameEn,
            message: isArabic ? serviceType.descAr : serviceType.descEn,
            onPressed: () {
              Common.instance.dismiss(context);
              _openWhatsapp(context);
            });
      }
    }
  }

  _openWhatsapp(BuildContext context) async {
    AboutUs aboutUs = BaseProvider.of<AppBloc>(context).generalDetails.aboutUs;

    String phone = "";
    if (Platform.isIOS) {
      phone = aboutUs.phone.replaceAll('+', '');
    } else {
      phone = aboutUs.phone;
    }
    String _url = "whatsapp://send?phone=$phone";
    Common.instance.loading(context);
    if (await canLaunch(_url)) {
      await launch(_url);
    }
    Common.instance.dismiss(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: serviceTypes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => _onServiceTypeTapped(context, index),
                child: ServiceTypeListContent(
                  serviceType: serviceTypes[index],
                ));
          }),
    );
  }
}
