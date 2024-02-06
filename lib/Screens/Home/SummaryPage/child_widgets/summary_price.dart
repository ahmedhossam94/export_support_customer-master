import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/SharedWisget/OrderInfo/order_info_price.dart';
import 'package:flutter/material.dart';

class SummaryPageContentPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BaseProvider.of<AppBloc>(context);
    SubmittedOrder submitOrder = appBloc.submittedOrder;

    return Container(
      child: OrderInfoPrice(
        vatPercentage: appBloc.generalDetails.submitOrder.vatPercentage,
        vatTotal: submitOrder.vatTotal,
        totalPriveWithVAT: submitOrder.totalPriveWithVAT,
      ),
    );
  }
}