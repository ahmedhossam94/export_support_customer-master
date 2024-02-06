import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/order_status.dart';
import 'package:export_support_customer/Models/user_order.dart';
import 'package:export_support_customer/SharedWisget/OrderInfo/order_info_price.dart';
import 'package:flutter/material.dart';

class OrderHistoryDetailsPageContentPrice extends StatelessWidget {
  OrderHistoryDetailsPageContentPrice({Key? key, required this.order})
      : super(key: key);

  final UserOrder order;

  @override
  Widget build(BuildContext context) {
    final num totalPrice = order.totalPriceAfterDiscount != 0.0
        ? order.totalPriceAfterDiscount
        : order.totalPriceBeforeDiscount;

    return Container(
      child: Column(
        children: <Widget>[
          OrderInfoPrice(
            discountPercent: order.discountPercent,
            totalDiscountAmount: order.totalDiscountAmount,
            totalPrice: totalPrice,
            vatPercentage: order.vatPercentage,
            vatTotal: order.vatTotal,
            totalPriveWithVAT: order.orderStatus == OrderStatus.done
                ? 0
                : order.totalPriveWithVAT,
            adminDiscount:
                order.orderStatus == OrderStatus.done ? 0 : order.adminDiscount,
          ),
        ],
      ),
    );
  }
}

class OrderHistoryDetailsPageContentAdditionalPrice extends StatelessWidget {
  OrderHistoryDetailsPageContentAdditionalPrice({Key? key, required this.order})
      : super(key: key);

  final UserOrder order;

  @override
  Widget build(BuildContext context) {
    final num totalPrice =
        order.totalPriveWithVAT + order.adminFees + order.partsTotal;
    final num totalRemaining = Common.instance
            .round(value: order.moneyReceived.toDouble(), places: 2) -
        Common.instance.round(value: totalPrice.toDouble(), places: 2);
    final String sign = totalRemaining > 0 ? "+" : "";
    final num adminDiscount =
        order.adminDiscount == null ? 0.0 : order.adminDiscount;

    return Container(
      child: Column(
        children: <Widget>[
          OrderInfoAdditionalPrice(
            adminFees: order.adminFees,
            partsTotal: order.partsTotal,
            totalPrice: totalPrice,
            totalPaid: order.moneyReceived,
            totalRemaining: totalRemaining,
            totalRemainingNumberSign: sign,
            adminDiscount: adminDiscount,
          )
        ],
      ),
    );
  }
}
