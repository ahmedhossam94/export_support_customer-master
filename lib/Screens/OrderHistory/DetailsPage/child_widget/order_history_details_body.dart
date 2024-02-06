import 'package:export_support_customer/HelperClass/order_status.dart';
import 'package:export_support_customer/Models/user_order.dart';
import 'package:export_support_customer/Screens/OrderHistory/DetailsPage/child_widget/order_history_details_main_info.dart';
import 'package:export_support_customer/Screens/OrderHistory/DetailsPage/child_widget/order_history_details_price.dart';
import 'package:export_support_customer/Screens/OrderHistory/DetailsPage/child_widget/order_history_details_service_list.dart';
import 'package:flutter/material.dart';

class OrderHistoryDetailsBody extends StatelessWidget {
  OrderHistoryDetailsBody({Key? key, required this.order, this.address = ""})
      : super(key: key);

  final UserOrder order;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          OrderHistoryDetailsPageContentMainInfo(
            order: order,
            address: address,
          ),
          Container(
            height: 8,
          ),
          OrderHistoryDetailsPageContentSeviceList(services: order.services),
          Container(
            height: 8,
          ),
          OrderHistoryDetailsPageContentPrice(order: order),
          order.orderStatus == OrderStatus.done
              ? OrderHistoryDetailsPageContentAdditionalPrice(
                  order: order,
                )
              : Container()
        ],
      ),
    );
  }
}
