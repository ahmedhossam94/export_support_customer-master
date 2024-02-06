import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class AppliedServicesHeader extends StatelessWidget {
  AppliedServicesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: Center(
          child: Text(
        localizations.translate(LocalizedKey.appliedServiceScreenHeaderTitle),
        style: TextStyle(
            fontSize: Screen.fontSize(size: 22), color: AppColor.darkRed),
      )),
    );
  }
}
