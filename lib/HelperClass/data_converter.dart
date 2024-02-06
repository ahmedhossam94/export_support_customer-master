//import 'package:expert_support_admin/HelperClass/app_localizations.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateConvert {
  static final instance = DateConvert();
  String completeDateFormula = 'EEEE dd MMM, yyyy';
  String dateFormula = 'yyyy-MM-dd';

  String toStringFromTimestamp(
      {required int timestamp, String? locale, bool isCompleteDate = false}) {
    final formula = isCompleteDate ? completeDateFormula : dateFormula;
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final dateFormat = DateFormat(formula, locale).format(date);

    return dateFormat;
  }

  String toStringFromDate(
      {required DateTime date, String? locale, bool isCompleteDate = false}) {
    final formula = isCompleteDate ? completeDateFormula : dateFormula;
    return DateFormat(formula, locale).format(date);
  }

  String timeToString(TimeOfDay timeOfDay, BuildContext context) {
    bool isArabic = AppLocalizations.of(context).isArabic();
    String time = timeOfDay.hourOfPeriod.toString() +
        ":" +
        timeOfDay.minute.toString() +
        " " +
        _getCurrentPeriod(timeOfDay.period, isArabic);
    return time;
  }

  String _getCurrentPeriod(DayPeriod period, bool isArabic) {
    if (period == DayPeriod.am) {
      return isArabic ? "صباحاً" : "AM";
    }
    return isArabic ? "مساءً" : "PM";
  }

  int getTimestamp({required DateTime date}) {
    return date.millisecondsSinceEpoch;
  }

  DateTime getDate({required int timestamp}) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}
