import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/Home/SummaryPage/child_widgets/summary_page_content_body.dart';
import 'package:export_support_customer/Screens/Home/SummaryPage/child_widgets/summary_page_content_header.dart';
import 'package:flutter/material.dart';

class SummaryPageContent extends StatefulWidget {
  SummaryPageContent({Key? key, required this.isKeyboardShowing})
      : super(key: key);

  final bool isKeyboardShowing;

  @override
  _SummaryPageContentState createState() => _SummaryPageContentState();
}

class _SummaryPageContentState extends State<SummaryPageContent> {
  @override
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _initPrice(BaseProvider.of<AppBloc>(context));
    });
    super.initState();
  }

  _initPrice(AppBloc appBloc) {
    SubmittedOrder submittedOrder = appBloc.submittedOrder;
    num vatPercentage = appBloc.generalDetails.submitOrder.vatPercentage != null
        ? (appBloc.generalDetails.submitOrder.vatPercentage / 100)
        : 0.05;

    submittedOrder.discountPercent = 0.0;
    submittedOrder.totalDiscountAmount = 0.0;
    submittedOrder.totalPriceBeforeDiscount =
        submittedOrder.totalPriceBeforeDiscount;
    submittedOrder.currentTotal = submittedOrder.totalPriceBeforeDiscount;
    submittedOrder.totalPriceAfterDiscount = 0.0;
    submittedOrder.vatPercentage =
        appBloc.generalDetails.submitOrder.vatPercentage;
    submittedOrder.vatTotal = submittedOrder.currentTotal * vatPercentage;
    submittedOrder.totalPriveWithVAT =
        submittedOrder.currentTotal + submittedOrder.vatTotal;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      SummaryPageContentHeader(),
      SummaryPageContentBody(),
    ];

    return Container(
        child: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: widgetList.length,
              itemBuilder: (_, index) => widgetList[index]),
        ),
        //isKeyboardShowing ? Container() : SummaryPageContentButtons(),
      ],
    ));
  }
}
