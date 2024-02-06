import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/BlocResources/submitted_order_bloc.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/data_converter.dart';
import 'package:export_support_customer/HelperClass/day_time.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/unavailable_date.dart';
import 'package:export_support_customer/Screens/Home/Appointment/child_widgets/appointment_calender_time.dart';
import 'package:export_support_customer/Screens/Home/Appointment/child_widgets/appointment_common.dart';
import 'package:flutter/material.dart';

class AppointmentDate extends StatefulWidget {
  @override
  _AppointmentDateState createState() => _AppointmentDateState();
}

class _AppointmentDateState extends State<AppointmentDate> {
  String _buttonTitle = '';
  AppBloc? _appBloc;
  SubmittedOrderBloc? _submittedOrderBloc;
  AppLocalizations? _localizations;

  @override
  void initState() {
    _submittedOrderBloc = SubmittedOrderBloc();
    super.initState();
  }

  _onSelectedDateAndTime(DateTime date, String time) {
    _appBloc?.submittedOrder.visitTime = time;
    _appBloc?.submittedOrder.visitDate = date;
    setState(() {
      _buttonTitle =
          _localizations!.translate(LocalizedKey.changeDateButtonTitle);
    });
  }

  String _getDisplayedTitle() {
    if (_appBloc?.submittedOrder.visitDate != null &&
        _appBloc?.submittedOrder.visitTime != null) {
      String selectedDateString = DateConvert.instance.toStringFromDate(
          date: _appBloc!.submittedOrder.visitDate ?? DateTime.now(),
          locale: _localizations!.locale!.languageCode,
          isCompleteDate: true);
      String time = DayTime().getDisplayStatus(
          dayTime: _appBloc!.submittedOrder.visitTime ?? '', context: context);

      return "$selectedDateString - $time";
    }
    return '';
  }

  _onButtonTapped() async {
    Common.instance.loading(context);
    UnavailableDate unavailableDate =
        await _submittedOrderBloc!.getUnavailableDate();
    Common.instance.dismiss(context);

    showDialog(
        context: context,
        builder: (_) => Dialog(
                child: AppointmentCalenderAndTime(
              selectedDate: _appBloc!.submittedOrder.visitDate,
              visitTime: _appBloc!.submittedOrder.visitTime,
              onOkayButtonTapped: _onSelectedDateAndTime,
              unavailableDate: unavailableDate,
            )));
  }

  _onOneHourReminderChange(bool? value) {
    setState(() {
      _appBloc?.submittedOrder.oneHourRminder = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _appBloc = BaseProvider.of<AppBloc>(context);
    _localizations = AppLocalizations.of(context);

    _buttonTitle = _appBloc?.submittedOrder.visitDate == null
        ? _localizations!.translate(LocalizedKey.setDateButtonTitle)
        : _localizations!.translate(LocalizedKey.changeDateButtonTitle);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppointmentCommon(
            text: _getDisplayedTitle(),
            buttonTitle: _buttonTitle,
            onPressed: () {
              _onButtonTapped();
            }),
        _getDisplayedTitle() != ''
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Checkbox(
                              value: _appBloc!.submittedOrder.oneHourRminder,
                              activeColor: AppColor.darkRed,
                              onChanged: _onOneHourReminderChange),
                        ),
                        Flexible(
                          child: Text(
                            _localizations!
                                .translate(LocalizedKey.oneHourMeReminder),
                            style:
                                TextStyle(fontSize: Screen.fontSize(size: 18)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : Container()
      ],
    );
  }
}
