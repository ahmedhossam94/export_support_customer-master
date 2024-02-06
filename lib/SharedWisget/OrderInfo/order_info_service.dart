import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class OrderInfoService extends StatelessWidget {
  OrderInfoService(
      {Key? key,
      required this.quantity,
      required this.serviceCategoryId,
      required this.serviceNameAr,
      required this.serviceNameEn,
      required this.totalPrice,
      this.isNeededPasts = false,
      this.isPackagesOffer = false,
      required this.serviceDetailsAr,
      required this.serviceDetailsEn})
      : super(key: key);

  final String quantity;
  final String serviceCategoryId;
  final String serviceNameAr;
  final String serviceNameEn;
  final String totalPrice;
  final bool isNeededPasts;
  final bool isPackagesOffer;
  final String serviceDetailsAr;
  final String serviceDetailsEn;

  @override
  Widget build(BuildContext context) {
    String imageName = isPackagesOffer
        ? Common.instance.getDealHomePageIconName()
        : Common.instance.getServiceCategoryIconName(serviceCategoryId);
    AppLocalizations localizations = AppLocalizations.of(context);
    bool isArabic = localizations.isArabic();
    String needPartTitle = isNeededPasts
        ? localizations.translate(LocalizedKey.yesTitle)
        : localizations.translate(LocalizedKey.noTitle);

    return Container(
      padding: EdgeInsets.only(left: 16, bottom: 8, right: 16),
      child: Row(
        children: <Widget>[
          Text("x$quantity"),
          Container(
            width: 16,
          ),
          Image(
            image: AssetImage(imageName),
            width: Screen.screenWidth * 0.065,
          ),
          Container(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  isArabic ? serviceNameAr : serviceNameEn,
                  style: TextStyle(fontSize: Screen.fontSize(size: 18)),
                ),
                isPackagesOffer
                    ? Container(
                        height: 4,
                      )
                    : Container(),
                isPackagesOffer
                    ? Text(isArabic ? serviceDetailsAr : serviceDetailsEn,
                        style: TextStyle(fontSize: Screen.fontSize(size: 14)))
                    : Container(),
                Container(
                  height: 4,
                ),
                Text(
                  localizations.translate(LocalizedKey.neededPartTitle) +
                      ": " +
                      needPartTitle,
                  style: TextStyle(fontSize: Screen.fontSize(size: 14)),
                )
              ],
            ),
          ),
          Container(
            width: 16,
          ),
          Text(totalPrice)
        ],
      ),
    );
  }
}
