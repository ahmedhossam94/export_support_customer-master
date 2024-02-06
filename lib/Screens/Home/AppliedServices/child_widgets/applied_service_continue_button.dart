import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/offer_status.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/Home/Appointment/appointment_page.dart';
import 'package:export_support_customer/SharedWisget/common_button.dart';
import 'package:flutter/material.dart';

class AppliedServiceContinueButton extends StatefulWidget {
  @override
  _AppliedServiceContinueButtonState createState() =>
      _AppliedServiceContinueButtonState();
}

class _AppliedServiceContinueButtonState
    extends State<AppliedServiceContinueButton> {
  AppBloc? _appBloc;
  AppLocalizations? _localizations;
  num? _limitRate;

  @override
  void initState() {
    _limitRate = 0.0;
    super.initState();
  }

  _onContinueButtonTapped() {
    final SubmittedOrder submittedOrder = _appBloc!.submittedOrder;
    submittedOrder.totalPriceBeforeDiscount = 0.0;
    if (submittedOrder.services!.isEmpty) {
      Alert().warning(
          context: context,
          message: _localizations!.translate(LocalizedKey.noServiceSelectTitle),
          onPressed: () {
            Common.instance.dismiss(context);
          });
    } else {
      submittedOrder.services!.forEach((s) {
        if (s.hasOffer && s.offerType == OfferType.packages) {
          submittedOrder.totalPriceBeforeDiscount += s.totalPrice!;
        } else {
          bool isOfferPrice = s.hasOffer && s.offerQuantity! <= s.quantity;
          num? price = isOfferPrice ? s.offerPrice : s.priceForOnePiece;

          submittedOrder.totalPriceBeforeDiscount += (price! * s.quantity);
        }
      });

      if (submittedOrder.totalPriceBeforeDiscount < _limitRate!) {
        Alert().warning(
            context: context,
            title:
                "${_localizations!.translate(LocalizedKey.orderPriceLimitErrorAlertTitle)} ${_limitRate!.toStringAsFixed(2)} SR",
            message:
                "${_localizations!.translate(LocalizedKey.orderPriceLimitErrorAlertMessage)}" +
                    "${_limitRate!.toStringAsFixed(2)} " +
                    "${_localizations!.translate(LocalizedKey.riyal_text)}. " +
                    "${_localizations!.translate(LocalizedKey.orderPriceLimitErrorAlertMessageDesc)}",
            onPressed: () {
              Common.instance.dismiss(context);
            });
      } else {
        Common.instance.notavigateTo(
            page: AppointmentPage(),
            pageName: "AppointmentPage",
            context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _appBloc = BaseProvider.of<AppBloc>(context);
    _localizations = AppLocalizations.of(context);
    _limitRate = _appBloc!.generalDetails.submitOrder.limitRate;

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            "${_localizations!.translate(LocalizedKey.minRateTitle)} " +
                "${_limitRate!.toStringAsFixed(2)} " +
                "${_localizations!.translate(LocalizedKey.riyal_text)}",
            style: TextStyle(
                fontSize: Screen.fontSize(size: 20), color: Colors.red),
          ),
          Container(
            height: 8,
          ),
          CommonButton(
            title: _localizations!.translate(LocalizedKey.continueButtonTitle),
            onPressed: () {
              _onContinueButtonTapped();
            },
          ),
        ],
      ),
    );
  }
}
