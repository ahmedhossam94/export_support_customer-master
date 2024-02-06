import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalnedar extends StatelessWidget {
  CustomCalnedar(
      {Key? key,
      required this.controller,
      this.selectedDate,
      this.onDaySelected,
      this.onUnavailableDaySelected,
      this.enabledDayPredicate})
      : super(key: key);

  final TableCalendar controller;
  final DateTime? selectedDate;
  final Function(DateTime, List<dynamic>, List<dynamic>)? onDaySelected;
  final Function()? onUnavailableDaySelected;
  final Function(DateTime)? enabledDayPredicate;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    bool isArabic = localizations.isArabic();

    return Container(
      child: TableCalendar(
        lastDay: DateTime(2099, 12, 31),
        firstDay: DateTime(1970, 1, 1),
        focusedDay: selectedDate ?? DateTime.now(),
        locale: isArabic ? "ar_SA" : "en_US",
        weekendDays: [DateTime.friday],
        startingDayOfWeek: StartingDayOfWeek.sunday,
        availableCalendarFormats: {
          CalendarFormat.month: 'Month',
        },
        availableGestures: AvailableGestures.horizontalSwipe,
        headerStyle: HeaderStyle(
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: Screen.fontSize(size: 18)),
          formatButtonVisible: false,
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
                color: Colors.white, fontSize: Screen.fontSize(size: 12)),
            weekendStyle: TextStyle(
                color: Colors.white, fontSize: Screen.fontSize(size: 12))),
      ),
    );
  }
}
