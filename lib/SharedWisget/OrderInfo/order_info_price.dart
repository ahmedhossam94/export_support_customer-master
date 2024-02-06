import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class OrderInfoPrice extends StatelessWidget {
  OrderInfoPrice(
      {Key? key,
      this.discountPercent,
      this.totalDiscountAmount,
      this.totalPrice,
      this.vatPercentage,
      this.vatTotal,
      this.totalPriveWithVAT,
      this.adminDiscount})
      : super(key: key);

  num? discountPercent = 0;
  num? totalDiscountAmount = 0;
  num? totalPrice = 0;
  num? vatPercentage = 0;
  num? vatTotal = 0;
  num? totalPriveWithVAT = 0;
  num? adminDiscount = 0;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    num percentage = vatPercentage ?? 5;

    return Container(
      child: Column(
        children: <Widget>[
          discountPercent != null
              ? PriceRow(
                  title: localizations.translate(LocalizedKey.discountTitle),
                  price: discountPercent ?? 0,
                  isPercentage: true,
                )
              : Container(),
          totalDiscountAmount != null
              ? PriceRow(
                  title:
                      localizations.translate(LocalizedKey.totalDiscountTitle),
                  price: totalDiscountAmount ?? 0,
                )
              : Container(),
          totalPrice != null
              ? PriceRow(
                  title: localizations.translate(LocalizedKey.total_title),
                  price: totalPrice ?? 0,
                )
              : Container(),
          PriceRow(
            title: localizations.translate(LocalizedKey.vatTotal) +
                ' (%$percentage)',
            price: vatTotal ?? 0,
          ),
          adminDiscount != null && adminDiscount != 0.0
              ? PriceRow(
                  title: localizations
                      .translate(LocalizedKey.admin_discount_title),
                  price: adminDiscount ?? 0)
              : Container(),
          totalPriveWithVAT != null
              ? PriceRow(
                  title: localizations.translate(LocalizedKey.totalPriceTitle),
                  price: totalPriveWithVAT ?? 0,
                )
              : Container(),
        ],
      ),
    );
  }
}

class OrderInfoAdditionalPrice extends StatelessWidget {
  OrderInfoAdditionalPrice(
      {Key? key,
      this.adminFees = 0.0,
      this.partsTotal = 0.0,
      this.totalPrice = 0.0,
      this.totalPaid = 0.0,
      this.totalRemaining = 0.0,
      this.totalRemainingNumberSign = "",
      this.adminDiscount = 0.0})
      : super(key: key);

  final num adminFees;
  final num partsTotal;
  final num totalPrice;
  final num totalPaid;
  final num totalRemaining;
  final String totalRemainingNumberSign;
  final num adminDiscount;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      child: Column(
        children: <Widget>[
          PriceRow(
            title: localizations.translate(LocalizedKey.adminFeeTitle),
            price: adminFees,
          ),
          PriceRow(
            title: localizations.translate(LocalizedKey.partsPriceTitle),
            price: partsTotal,
          ),
          adminDiscount != null || adminDiscount != 0.0
              ? PriceRow(
                  title: localizations
                      .translate(LocalizedKey.admin_discount_title),
                  price: adminDiscount)
              : Container(),
          PriceRow(
            title: localizations.translate(LocalizedKey.totalPriceTitle),
            price: totalPrice,
          ),
          PriceRow(
            title: localizations.translate(LocalizedKey.totalPaidTitle),
            price: totalPaid,
          ),
          totalRemaining != 0.0
              ? PriceRow(
                  title:
                      localizations.translate(LocalizedKey.totalRemainingTitle),
                  price: totalRemaining,
                  numberSign: totalRemainingNumberSign,
                )
              : Container(),
        ],
      ),
    );
  }
}

class PriceRow extends StatelessWidget {
  final String title;
  final num price;
  final bool isPercentage;
  final String numberSign;
  PriceRow(
      {Key? key,
      required this.title,
      required this.price,
      this.isPercentage = false,
      this.numberSign = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    String currency = isPercentage
        ? "%"
        : " ${localizations.translate(LocalizedKey.riyal_text)}";

    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: Screen.fontSize(size: 18)),
            ),
          ),
          Container(
            width: 8,
          ),
          Text(
            "$numberSign${price.toStringAsFixed(isPercentage ? 0 : 2)}$currency",
            style: TextStyle(fontSize: Screen.fontSize(size: 18)),
          ), //toStringAsFixed(2) to show two decimal point.
        ],
      ),
    );
  }
}
