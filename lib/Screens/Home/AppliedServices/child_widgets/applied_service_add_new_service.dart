import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class AppliedServicesAddNewService extends StatelessWidget {
  AppliedServicesAddNewService({Key? key, required this.onTap})
      : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: AppColor.lightDarkGray,
          border: Border(bottom: BorderSide(color: Colors.black, width: 1.5))),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage(ImageName.addIcon),
              height: Screen.screenWidth * 0.07,
            ),
            Container(
              width: 4,
            ),
            Text(
              localizations.translate(LocalizedKey.addNewServiceTitle),
              style: TextStyle(
                  fontSize: Screen.fontSize(size: 20), color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
