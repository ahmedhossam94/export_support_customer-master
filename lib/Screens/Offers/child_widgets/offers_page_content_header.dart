import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class OffersListContentHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              localizations.translate(LocalizedKey.dealTitle),
              style: TextStyle(
                fontSize: Screen.fontSize(size: 22),
                color: AppColor.darkRed
              ),
            )
          ),
          Container(height: 8),
          Center(
            child: Image(image: AssetImage(ImageName.deals),
              height: Screen.screenWidth * 0.15,
            )
          ),
          Container(height: 16),
        ]
      ),
    );
  }
}