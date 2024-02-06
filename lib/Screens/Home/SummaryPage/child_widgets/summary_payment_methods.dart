import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/payment.dart';
import 'package:flutter/material.dart';

class SummaryPageContentPaymentMethod extends StatefulWidget {
  @override
  _SummaryPageContentPaymentMethodState createState() =>
      _SummaryPageContentPaymentMethodState();
}

class _SummaryPageContentPaymentMethodState
    extends State<SummaryPageContentPaymentMethod> {
  AppBloc? _appBloc;
  AppLocalizations? _localizations;

  _onPaymentChange(String? value) {
    if (value == Payment.cash &&
        !_appBloc!.generalDetails.submitOrder.isCashEnabled) {
      Alert().warning(
          context: context,
          message: _localizations!
              .translate(LocalizedKey.notAvailableCashPaymentMethodTitle),
          onPressed: () {
            Common.instance.dismiss(context);
          });
    } else if (value == Payment.pos &&
        !_appBloc!.generalDetails.submitOrder.isPOSEnabled) {
      Alert().warning(
          context: context,
          message: _localizations!
              .translate(LocalizedKey.notAvailablePOSPaymentMethodTitle),
          onPressed: () {
            Common.instance.dismiss(context);
          });
    } else {
      setState(() {
        _appBloc?.submittedOrder.paymentMethod = value ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _appBloc = BaseProvider.of<AppBloc>(context);
    _localizations = AppLocalizations.of(context);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            _localizations!.translate(LocalizedKey.paymentMethodSectionHeader),
            style: TextStyle(
                fontSize: Screen.fontSize(size: 22),
                color: Colors.black,
                fontWeight: FontWeight.w700),
          ),
          SummaryPageContentPaymentRadio(
            title:
                _localizations!.translate(LocalizedKey.paymentMethodCashTitle),
            subtitle: _localizations!
                .translate(LocalizedKey.paymentMethodCashSubtitle),
            value: Payment.cash,
            groupValue: _appBloc!.submittedOrder.paymentMethod,
            onChanged: _onPaymentChange,
            enable: _appBloc!.generalDetails.submitOrder.isCashEnabled,
          ),
          Container(
            height: 8,
          ),
          SummaryPageContentPaymentRadio(
            title:
                _localizations!.translate(LocalizedKey.paymentMethodPOSTitle),
            subtitle: _localizations!
                .translate(LocalizedKey.paymentMethodPOSSubtitle),
            value: Payment.pos,
            groupValue: _appBloc!.submittedOrder.paymentMethod,
            onChanged: _onPaymentChange,
            enable: _appBloc!.generalDetails.submitOrder.isPOSEnabled,
          ),
        ],
      ),
    );
  }
}

class SummaryPageContentPaymentRadio extends StatelessWidget {
  SummaryPageContentPaymentRadio(
      {Key? key,
      required this.onChanged,
      this.value,
      this.title,
      this.subtitle,
      this.groupValue,
      this.enable = true})
      : super(key: key);

  String? value = '';
  String? title = '';
  String? subtitle = '';
  String? groupValue = '';
  void Function(String?) onChanged;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:
          ThemeData(unselectedWidgetColor: enable ? Colors.black : Colors.grey),
      child: Row(children: <Widget>[
        Radio<String>(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: value ?? '',
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColor.darkRed,
        ),
        Container(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title ?? '',
              style: TextStyle(
                  fontSize: Screen.fontSize(size: 18),
                  color: enable ? Colors.black : Colors.grey),
            ),
            Text(
              subtitle ?? '',
              style: TextStyle(
                  fontSize: Screen.fontSize(size: 14),
                  color: enable ? Colors.black : Colors.grey),
            ),
          ],
        ),
      ]),
    );
  }
}
