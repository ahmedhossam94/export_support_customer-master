import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/offer_status.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/child_widgets/applied_service_needed_parts.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/child_widgets/applied_service_quantity.dart';
import 'package:flutter/material.dart';

class AppliedServicesListContentHeader extends StatefulWidget {
  AppliedServicesListContentHeader({Key? key, required this.submittedService})
      : super(key: key);

  final SubmittedService submittedService;

  @override
  _AppliedServicesListContentHeaderState createState() =>
      _AppliedServicesListContentHeaderState();
}

class _AppliedServicesListContentHeaderState
    extends State<AppliedServicesListContentHeader> {
  AppLocalizations? _localizations;
  bool _isArabic = false;

  @override
  void initState() {
    super.initState();
  }

  String get _imageName {
    if (widget.submittedService.hasOffer &&
        (widget.submittedService.offerType == OfferType.packages)) {
      return Common.instance.getDealHomePageIconName();
    }

    return Common.instance
        .getServiceCategoryIconName(widget.submittedService.serviceCategoryId);
  }

  String? get _serviceName {
    String? nameAr = widget.submittedService.offerType == OfferType.packages
        ? widget.submittedService.offerNameAr
        : widget.submittedService.nameAr;

    String? nameEn = widget.submittedService.offerType == OfferType.packages
        ? widget.submittedService.offerNameEn
        : widget.submittedService.nameEn;

    return _isArabic ? nameAr : nameEn;
  }

  bool get _isOfferPrice {
    return widget.submittedService.hasOffer &&
        (widget.submittedService.offerQuantity! <=
            widget.submittedService.quantity);
  }

  bool get _hasPrice {
    return _isOfferPrice
        ? widget.submittedService.offerPrice != 0
        : widget.submittedService.priceForOnePiece != 0;
  }

  String get _priceDisplayWithCurrency {
    num? price = _isOfferPrice
        ? widget.submittedService.offerPrice
        : widget.submittedService.priceForOnePiece;

    return "${price!.toStringAsFixed(2)} " +
        "${_localizations!.translate(LocalizedKey.riyal_text)}";
  }

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);
    _isArabic = _localizations!.isArabic();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: AppColor.lightDarkGray,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image(
                image: AssetImage(_imageName),
                height: Screen.screenWidth * 0.06,
              ),
              Container(
                width: 16,
              ),
              Expanded(
                child: Text(
                  _serviceName!,
                  style: TextStyle(
                      fontSize: Screen.fontSize(size: 22), color: Colors.white),
                ),
              ),
              Container(
                width: 16,
              ),
              _hasPrice
                  ? Text(_priceDisplayWithCurrency,
                      style: TextStyle(
                          fontSize: Screen.fontSize(size: 20),
                          color: Colors.white))
                  : Container()
            ],
          ),
        ],
      ),
    );
  }
}

class AppliedServicesListContentBody extends StatelessWidget {
  AppliedServicesListContentBody(
      {Key? key,
      required this.onRemove,
      required this.onNeededPartsChange,
      this.onQuantityChange,
      this.qauntity,
      this.neededParts,
      this.dropdownButtonEnabled = true})
      : super(key: key);

  final VoidCallback? onRemove;
  final int? qauntity;
  final Function(int)? onQuantityChange;
  final bool? neededParts;
  final Function(bool)? onNeededPartsChange;
  final bool? dropdownButtonEnabled;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                dropdownButtonEnabled!
                    ? AppliedServicesQuantity(
                        onQuantityChange: onQuantityChange!,
                        qauntity: qauntity ?? 0,
                      )
                    : Container(),
                AppliedServicesCheckbox(
                  onChangeNeededParts: onNeededPartsChange!,
                  neededParts: neededParts ?? false,
                )
              ],
            ),
          ),
          Container(
            width: 8,
          ),
          ElevatedButton(
              onPressed: onRemove,
              child: Text(
                  localizations.translate(LocalizedKey.removeButtonTitle),
                  style: TextStyle(
                      fontSize: Screen.fontSize(size: 18), color: Colors.red)))
        ],
      ),

      // Column(
      //   children: <Widget>[
      //     Row(
      //       children: <Widget>[
      //         Expanded(
      //           child: AppliedServicesQuantity(
      //             onQuantityChange: onQuantityChange,
      //             qauntity: qauntity,
      //             enabled: dropdownButtonEnabled,
      //           )
      //         ),
      //         Container(width: 16,),
      //         FlatButton(
      //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //           onPressed: onRemove,
      //           child: Text(localizations.translate(LocalizedKey.removeButtonTitle), style: TextStyle(fontSize: Screen.fontSize(size: 18), color: Colors.red))
      //         )
      //       ],
      //     ),
      //     AppliedServicesCheckbox(
      //       onChangeNeededParts: onNeededPartsChange,
      //       neededParts: neededParts,
      //     )
      //   ],
      // ),
    );
  }
}
