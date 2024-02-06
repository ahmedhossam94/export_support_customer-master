import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/data_converter.dart';
import 'package:export_support_customer/HelperClass/delegates.dart';
import 'package:export_support_customer/HelperClass/order_status.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Models/user_order.dart';
import 'package:export_support_customer/Screens/OrderHistory/DetailsPage/order_history_details_page.dart';
import 'package:flutter/material.dart';

class OrderHistoryPageList extends StatelessWidget
    implements OrderHistoryDelegate {
  OrderHistoryPageList(
      {Key? key,
      required this.orderHistoryList,
      required this.updateOrderHistoryIfReqiure})
      : super(key: key);

  final List<UserOrder> orderHistoryList;
  final Function() updateOrderHistoryIfReqiure;

  _onServiceTypeTapped(BuildContext context, int index) {
    Common.instance.notavigateTo(
        page: OrderHistoryDetailsPage(
          order: orderHistoryList[index],
          orderHistoryDelegate: this,
        ),
        pageName: "OrderHistoryDetailsPage",
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: orderHistoryList.length,
          itemBuilder: (_, index) {
            return GestureDetector(
                onTap: () => _onServiceTypeTapped(context, index),
                child: OrderHistoryPageItem(
                  orderHistory: orderHistoryList[index],
                ));
          }),
    );
  }

  @override
  void isReqiureUpdate(bool isReqiure) {
    if (isReqiure) {
      updateOrderHistoryIfReqiure();
    }
  }
}

class OrderHistoryPageItem extends StatelessWidget {
  OrderHistoryPageItem({Key? key, required this.orderHistory})
      : super(key: key);

  final UserOrder orderHistory;

  @override
  Widget build(BuildContext context) {
    bool isArabic = AppLocalizations.of(context).isArabic();
    final String orderID = orderHistory.id;
    final String orderCreateDate =
        DateConvert.instance.toStringFromDate(date: orderHistory.dateCreated);
    final String orderStatus = OrderStatus.instance
        .getDisplayStatus(status: orderHistory.orderStatus, context: context);
    final Color orderStatusColor = OrderStatus.instance
        .getOrderStatusColor(status: orderHistory.orderStatus);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 0.2))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          orderID,
                          style: TextStyle(fontSize: Screen.fontSize(size: 22)),
                        ),
                        Text(
                          orderCreateDate,
                          style: TextStyle(fontSize: Screen.fontSize(size: 18)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 8,
                  ),
                  Text(
                    orderStatus,
                    style: TextStyle(
                        fontSize: Screen.fontSize(size: 22),
                        color: orderStatusColor),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 16,
          ),
          Icon(
            isArabic ? Icons.keyboard_arrow_left : Icons.keyboard_arrow_right,
          )
        ],
      ),
    );
  }
}
