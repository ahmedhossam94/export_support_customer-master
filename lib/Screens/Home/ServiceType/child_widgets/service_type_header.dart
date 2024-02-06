import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class ServiceTypeHeader extends StatelessWidget {
  final String serviceID;
  final String serviceName;
  ServiceTypeHeader(
      {Key? key, required this.serviceID, required this.serviceName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      child: Column(children: <Widget>[
        Center(
            child: Text(
          localizations.translate(LocalizedKey.serviceTypeScreenHeaderTitle),
          style: TextStyle(
              fontSize: Screen.fontSize(size: 22), color: AppColor.darkRed),
        )),
        Container(height: 16),
        Center(
            child: Image(
          image:
              AssetImage(Common.instance.getServiceCategoryIconName(serviceID)),
          height: Screen.screenWidth * 0.15,
        )),
        Container(height: 16),
      ]),
    );
  }
}
