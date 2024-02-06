import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/data_converter.dart';
import 'package:export_support_customer/HelperClass/day_time.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/SharedWisget/OrderInfo/order_info_main.dart';
import 'package:flutter/material.dart';

class SummaryPageContentMainInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BaseProvider.of<AppBloc>(context);
    AppLocalizations localizations = AppLocalizations.of(context);
    SubmittedOrder submitOrder = appBloc.submittedOrder;

    return Container(
      child: OrderInfoMain(
        visitDate: DateConvert.instance.toStringFromDate(
            date: submitOrder.visitDate ?? DateTime.now(),
            locale: localizations.locale!.languageCode,
            isCompleteDate: true),
        visitTime: DayTime().getDisplayStatus(
            dayTime: submitOrder.visitTime ?? '', context: context),
        location: submitOrder.address,
        comment: submitOrder.comment,
        oneDayReminder: submitOrder.oneDayReminder,
        oneHourRminder: submitOrder.oneHourRminder,
      ),
    );
  }
}
