import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class OrderInfoMain extends StatelessWidget {
  OrderInfoMain(
      {Key? key,
      this.status,
      this.visitDate,
      this.visitTime,
      this.location,
      this.comment,
      this.oneDayReminder,
      this.oneHourRminder})
      : super(key: key);

  final String? status;
  final String? visitDate;
  final String? visitTime;
  final String? location;
  final String? comment;
  final bool? oneDayReminder;
  final bool? oneHourRminder;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    bool hasReminder = oneDayReminder ?? false || (oneHourRminder ?? false);
    return Container(
      child: Column(
        children: <Widget>[
          status == null
              ? Container()
              : OrderInfoRow(
                  title: localizations.translate(LocalizedKey.statusTitle),
                  value: status ?? '',
                ),
          OrderInfoRow(
            title: localizations.translate(LocalizedKey.dateTitle),
            value: visitDate ?? '',
          ),
          OrderInfoRow(
            title: localizations.translate(LocalizedKey.timeTitle),
            value: visitTime ?? '',
          ),
          OrderInfoRow(
            title: localizations.translate(LocalizedKey.locationTitle),
            value: location ?? "",
          ),
          comment == null || comment!.isEmpty
              ? Container()
              : OrderInfoRow(
                  title:
                      localizations.translate(LocalizedKey.otherDetailsTitle),
                  value: comment ?? '',
                ),
          hasReminder
              ? OrderReminderRow(
                  title: localizations.translate(LocalizedKey.reminder_title),
                  isOneDayReminder: oneDayReminder ?? false,
                  isOneHourReminder: oneHourRminder ?? false,
                )
              : Container()
        ],
      ),
    );
  }
}

class OrderInfoRow extends StatelessWidget {
  final String title;
  final String value;
  OrderInfoRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: <Widget>[
          Container(
              alignment: FractionalOffset.topCenter,
              child: Text(
                title + ":",
                style: TextStyle(
                    fontSize: Screen.fontSize(size: 18),
                    fontWeight: FontWeight.w700),
              )),
          Container(
            width: 8,
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: Screen.fontSize(size: 18)),
            ),
          )
        ],
      ),
    );
  }
}

class OrderReminderRow extends StatelessWidget {
  final String title;
  final bool isOneDayReminder;
  final bool isOneHourReminder;
  OrderReminderRow(
      {Key? key,
      required this.title,
      required this.isOneDayReminder,
      required this.isOneHourReminder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    final String oneDayReminderTitle =
        localizations.translate(LocalizedKey.oneDayReminderTitle);
    final String oneHourReminderTitle =
        localizations.translate(LocalizedKey.oneHourReminderTitle);
    bool isArabic = localizations.isArabic();

    return Container(
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title + ":",
                style: TextStyle(
                    fontSize: Screen.fontSize(size: 18),
                    fontWeight: FontWeight.w700),
              ),
              Container(
                padding: isArabic
                    ? EdgeInsets.only(right: 16)
                    : EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    isOneHourReminder
                        ? Text(
                            oneHourReminderTitle,
                            style: TextStyle(
                                fontSize: Screen.fontSize(size: 16),
                                color: AppColor.lightGray),
                          )
                        : Container(),
                    Container(
                      height: 8,
                    ),
                    isOneDayReminder
                        ? Text(
                            oneDayReminderTitle,
                            style: TextStyle(
                                fontSize: Screen.fontSize(size: 16),
                                color: AppColor.lightGray),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
