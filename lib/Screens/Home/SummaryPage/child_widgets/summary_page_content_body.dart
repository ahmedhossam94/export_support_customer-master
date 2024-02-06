import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/Models/discount.dart';
import 'package:export_support_customer/Screens/Home/SummaryPage/child_widgets/summary_action_buttons.dart';
import 'package:export_support_customer/Screens/Home/SummaryPage/child_widgets/summary_discount.dart';
import 'package:export_support_customer/Screens/Home/SummaryPage/child_widgets/summary_main_info.dart';
import 'package:export_support_customer/Screens/Home/SummaryPage/child_widgets/summary_payment_methods.dart';
import 'package:export_support_customer/Screens/Home/SummaryPage/child_widgets/summary_price.dart';
import 'package:export_support_customer/Screens/Home/SummaryPage/child_widgets/summary_service_list.dart';
import 'package:flutter/material.dart';

class SummaryPageContentBody extends StatefulWidget {
  @override
  _SummaryPageContentBodyState createState() => _SummaryPageContentBodyState();
}

class _SummaryPageContentBodyState extends State<SummaryPageContentBody> {
  AppBloc? _appBloc;
  TextEditingController? _dicountCodeTextController;

  @override
  initState() {
    _dicountCodeTextController = TextEditingController();
    super.initState();
  }

  _onApplyDicountCode(Discount discount) {
    setState(() {
      _updatePrices(discount.percentage);
    });
  }

  _updatePrices(num percentage) {
    double totalDiscount =
        _appBloc!.submittedOrder.totalPriceBeforeDiscount * (percentage / 100);
    double currentTotal = _appBloc!.submittedOrder.currentTotal.toDouble();
    num vatPercentage =
        _appBloc!.generalDetails.submitOrder.vatPercentage != null
            ? (_appBloc!.generalDetails.submitOrder.vatPercentage / 100)
            : 0.05;

    _appBloc?.submittedOrder.discountPercent = percentage;
    _appBloc?.submittedOrder.totalDiscountAmount = totalDiscount;
    _appBloc?.submittedOrder.currentTotal = currentTotal - totalDiscount;
    _appBloc?.submittedOrder.totalPriceAfterDiscount =
        currentTotal - totalDiscount;
    _appBloc?.submittedOrder.vatTotal =
        _appBloc!.submittedOrder.currentTotal * vatPercentage;
    _appBloc?.submittedOrder.totalPriveWithVAT =
        _appBloc!.submittedOrder.currentTotal +
            _appBloc!.submittedOrder.vatTotal;
  }

  @override
  Widget build(BuildContext context) {
    _appBloc = BaseProvider.of<AppBloc>(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          SummaryPageContentMainInfo(),
          Container(
            height: 8,
          ),
          SummaryPageContentSeviceList(),
          Container(
            height: 8,
          ),
          SummaryPageContentPaymentMethod(),
          Container(
            height: 8,
          ),
          SummaryPageContentDiscount(
            dicountCodeTextController: _dicountCodeTextController!,
            onApplyDiscount: _onApplyDicountCode,
          ),
          Container(
            height: 8,
          ),
          SummaryPageContentPrice(),
          Container(
            height: 8,
          ),
          SummaryPageContentButtons(),
        ],
      ),
    );
  }
}
