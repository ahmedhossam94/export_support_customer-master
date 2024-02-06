import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/Home/SummaryPage/summary_page.dart';
import 'package:export_support_customer/SharedWisget/common_button.dart';
import 'package:flutter/material.dart';

class AppointmentPageContinueButton extends StatefulWidget {
  @override
  _AppointmentPageContinueButtonState createState() =>
      _AppointmentPageContinueButtonState();
}

class _AppointmentPageContinueButtonState
    extends State<AppointmentPageContinueButton> {
  AppBloc? _appBloc;
  AppLocalizations? _localizations;

  @override
  void initState() {
    super.initState();
  }

  _onContinueButtonTapped() {
    final SubmittedOrder submittedOrder = _appBloc!.submittedOrder;
    Common.instance.removeFocus(context);

    if (submittedOrder.visitDate == null &&
        submittedOrder.visitTime == null &&
        submittedOrder.coordinate == null) {
      _warningAlert(_localizations!
          .translate(LocalizedKey.notSelectDateLocationAlertMessage));
    } else if (submittedOrder.visitDate == null &&
        submittedOrder.visitTime == null) {
      _warningAlert(_localizations!
          .translate(LocalizedKey.notSelectDateTimeAlertMessage));
    } else if (submittedOrder.coordinate == null) {
      _warningAlert(_localizations!
          .translate(LocalizedKey.notSelectLocationAlertMessage));
    } else {
      Common.instance.notavigateTo(
          page: SummaryPage(), pageName: "SummaryPage", context: context);
    }
  }

  _warningAlert(String message) {
    Alert().warning(
        context: context,
        message: message,
        onPressed: () {
          Common.instance.dismiss(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    _appBloc = BaseProvider.of<AppBloc>(context);
    _localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: CommonButton(
        title: _localizations!.translate(LocalizedKey.continueButtonTitle),
        onPressed: () {
          _onContinueButtonTapped();
        },
      ),
    );
  }
}
