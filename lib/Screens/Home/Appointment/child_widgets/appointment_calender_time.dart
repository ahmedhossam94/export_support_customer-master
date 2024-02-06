import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/data_converter.dart';
import 'package:export_support_customer/HelperClass/day_time.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/unavailable_date.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/Home/Appointment/child_widgets/appointment_custom_calender.dart';
import 'package:export_support_customer/Screens/Home/Appointment/child_widgets/appointment_visit_time_radio.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentCalenderAndTime extends StatefulWidget {
  AppointmentCalenderAndTime(
      {Key? key,
      this.selectedDate,
      this.visitTime,
      this.onOkayButtonTapped,
      this.unavailableDate})
      : super(key: key);

  final DateTime? selectedDate;
  final String? visitTime;
  final Function(DateTime, String)? onOkayButtonTapped;
  final UnavailableDate? unavailableDate;

  @override
  _AppointmentCalenderAndTimeState createState() =>
      _AppointmentCalenderAndTimeState();
}

class _AppointmentCalenderAndTimeState
    extends State<AppointmentCalenderAndTime> {
  TableCalendar<dynamic>? _calendarController;
  DateTime? _selectedDate;
  String _visitTime = '';
  bool _isMorningVisible = false;
  AppLocalizations? _localizations;

  @override
  initState() {
    _calendarController = TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(Duration(days: 365)));
    _selectedDate = widget.selectedDate;
    _visitTime = widget.visitTime ?? '';
    _isMorningVisible = _isMoningVisible();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isMoningVisible() {
    if (_selectedDate == null) {
      return true;
    }
    bool isToday = _calendarController!.selectedDayPredicate!(_selectedDate!);
    bool isInvalidMorningTime = TimeOfDay.now().hour >= 11;

    return !(isToday && isInvalidMorningTime);
  }

  bool _isValidDate(DateTime date) {
    if (date == null) {
      return true;
    }
    bool isToday = _calendarController!.selectedDayPredicate!(date);
    bool isInvalidTodayTime = TimeOfDay.now().hour >= 22;

    return !(isToday && isInvalidTodayTime);
  }

  _onDaySelected(
      DateTime selectedDate, List<dynamic> events, List<dynamic> events2) {
    print("selected date: ${selectedDate.toString()}");
    print("Timestap: ${DateConvert().getTimestamp(date: selectedDate)}");
    setState(() {
      _selectedDate = _isValidDate(selectedDate) ? selectedDate : null;
      _isMorningVisible = _isMoningVisible();
      _visitTime = (_isMorningVisible ? null : VisitTime.evening)!;
    });
  }

  _onUnavailableDaySelected() {
    Alert().warning(
        context: context,
        title:
            _localizations!.translate(LocalizedKey.unavailableDateAlertTitle),
        message:
            _localizations!.translate(LocalizedKey.unavailableDateAlertMessage),
        onPressed: () {
          Common.instance.dismiss(context);
        });
  }

  bool _enabledDayPredicate(DateTime date) {
    if (date.weekday == DateTime.friday) {
      return false;
    } else if (widget.unavailableDate != null &&
        widget.unavailableDate?.timestampList != null &&
        widget.unavailableDate!.timestampList!
            .contains(DateConvert.instance.getTimestamp(date: date))) {
      return false;
    } else if (widget.unavailableDate != null &&
        widget.unavailableDate?.startDateTimestamp != null &&
        widget.unavailableDate?.endDateTimestamp != null &&
        (widget.unavailableDate!.startDateTimestamp! <=
                DateConvert.instance.getTimestamp(date: date) &&
            DateConvert.instance.getTimestamp(date: date) <=
                widget.unavailableDate!.endDateTimestamp!)) {
      return false;
    }
    return true;
  }

  _onVisitTimeChange(String? value) {
    setState(() {
      _visitTime = value ?? '';
    });
  }

  _onOkayButtonTapped() {
    if (_selectedDate == null) {
      _warningAlert(
          _localizations!.translate(LocalizedKey.notSelectDateAlertMessage));
    } else if (_visitTime == null) {
      _warningAlert(
          _localizations!.translate(LocalizedKey.notSelectTimeAlertMessage));
    } else {
      widget.onOkayButtonTapped!(_selectedDate!, _visitTime);
      Common.instance.dismiss(context);
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
    _localizations = AppLocalizations.of(context);

    return Container(
      color: AppColor.darkRed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomCalnedar(
            controller: _calendarController ??
                TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(Duration(days: 365)),
                ),
            selectedDate: _selectedDate,
            onDaySelected: _onDaySelected,
            onUnavailableDaySelected: _onUnavailableDaySelected,
            enabledDayPredicate: _enabledDayPredicate,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _isMorningVisible
                    ? AppointmentVisitTimeRadio(
                        value: DayTime.morning,
                        visitTime: _visitTime,
                        onVisitTimeChange: _onVisitTimeChange,
                      )
                    : Container(),
                AppointmentVisitTimeRadio(
                  value: DayTime.evening,
                  visitTime: _visitTime,
                  onVisitTimeChange: _onVisitTimeChange,
                ),
              ],
            ),
          ),
          Container(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey, width: 1))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                    onPressed: _onOkayButtonTapped,
                    child: Text(
                      _localizations!.translate(LocalizedKey.okayButtonTitle),
                      style: TextStyle(
                          fontSize: Screen.fontSize(size: 20),
                          color: Colors.white),
                    )),
                Container(),
                ElevatedButton(
                    onPressed: () {
                      Common.instance.dismiss(context);
                    },
                    child: Text(
                      _localizations!.translate(LocalizedKey.cancelButtonTitle),
                      style: TextStyle(
                          fontSize: Screen.fontSize(size: 20),
                          color: Colors.white),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
