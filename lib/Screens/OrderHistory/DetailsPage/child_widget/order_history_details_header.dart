import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class OrderHistoryDetailsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    return Center(
      child: Text(
        localizations.translate(LocalizedKey.orderDetailsHeaderTitle),
        style: TextStyle(
          fontSize: Screen.fontSize(size: 24),
          color: AppColor.darkRed
        ),
      ),
    );
  }
}