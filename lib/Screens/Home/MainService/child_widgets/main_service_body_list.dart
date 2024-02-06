import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:flutter/material.dart';

class MainServiceBodyList extends StatelessWidget {
  final MainService mainService;
  MainServiceBodyList({Key? key, required this.mainService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    bool isArabic = localizations.isArabic();
    String imageName = Common.instance.getACTypeImage(mainService.type);

    return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: AppColor.lightDarkGray,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            imageName != ""
                ? Image(
                    image: AssetImage(imageName),
                    height: Screen.screenWidth * .09,
                    width: Screen.screenWidth * .1,
                  )
                : Container(
                    height: Screen.screenWidth * .09,
                    width: Screen.screenWidth * .1,
                  ),
            Container(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    isArabic ? mainService.nameAr : mainService.nameEn,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Screen.fontSize(size: 22)),
                  ),
                  Container(
                    height: 4,
                  ),
                  Text(
                    "${mainService.price} ${localizations.translate(LocalizedKey.riyal_text)} " +
                        (isArabic
                            ? mainService.priceDescAr
                            : mainService.priceDescEn),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Screen.fontSize(size: 20)),
                  )
                ],
              ),
            ),
            Container(
              width: 16,
            ),
            Image(
              image: AssetImage(
                isArabic ? ImageName.leftArrow : ImageName.rightArrow,
              ),
              height: Screen.screenWidth * 0.065,
              width: Screen.screenWidth * 0.06,
            )
          ],
        ));
  }
}
