import 'package:export_support_customer/HelperClass/data_converter.dart';
import 'package:export_support_customer/HelperClass/day_time.dart';
import 'package:export_support_customer/HelperClass/order_status.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Models/user_order.dart';
import 'package:export_support_customer/SharedWisget/OrderInfo/order_info_main.dart';
import 'package:flutter/material.dart';

class OrderHistoryDetailsPageContentMainInfo extends StatelessWidget {
  OrderHistoryDetailsPageContentMainInfo(
      {Key? key, required this.order, this.address = ""})
      : super(key: key);

  final UserOrder order;
  final String address;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    String status = OrderStatus.instance
        .getDisplayStatus(status: order.orderStatus, context: context);
    String visitDate = DateConvert().toStringFromDate(
        date: order.visitDate,
        locale: localizations.locale!.languageCode,
        isCompleteDate: true);
    String visitTime = order.fullDateAndTimeToVisit != null
        ? TimeOfDay(
                hour: order.fullDateAndTimeToVisit.hour,
                minute: order.fullDateAndTimeToVisit.minute)
            .format(context)
        : DayTime()
            .getDisplayStatus(dayTime: order.visitTime, context: context);

    return Container(
      child: OrderInfoMain(
        status: status,
        visitDate: visitDate,
        visitTime: visitTime,
        location:
            address, //"${order.coordinate.latitude}, ${order.coordinate.longitude}",
        comment: order.comment,
        oneDayReminder: order.oneDayReminder,
        oneHourRminder: order.oneHourRminder,
      ),
    );
  }
}
