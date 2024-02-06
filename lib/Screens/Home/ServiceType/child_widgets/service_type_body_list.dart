import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:flutter/material.dart';

class ServiceTypeListContent extends StatelessWidget {
  final ServiceType serviceType;
  ServiceTypeListContent({Key? key, required this.serviceType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    bool isArabic = localizations.isArabic();

    return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: AppColor.lightDarkGray,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isArabic ? serviceType.nameAr : serviceType.nameEn,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Screen.fontSize(size: 20)),
                  ),
                  Text(
                    isArabic ? serviceType.descAr : serviceType.descEn,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Screen.fontSize(size: 16)),
                  )
                ],
              ),
            ),
            Image(
              image: AssetImage(
                isArabic ? ImageName.leftArrow : ImageName.rightArrow,
              ),
              height: Screen.screenWidth * 0.065,
            )
          ],
        ));
  }
}
