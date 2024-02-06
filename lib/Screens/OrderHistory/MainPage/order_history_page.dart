import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/FirebaseResources/firebase_manager.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/user_order.dart';
import 'package:export_support_customer/Screens/OrderHistory/MainPage/order_history_list_page.dart';
import 'package:export_support_customer/SharedWisget/loader.dart';
import 'package:export_support_customer/SharedWisget/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderHistoryPage extends StatelessWidget {
  static const String route = "/OrderHistoryPage";

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BaseProvider.of(context);

    return SafeArea(
        child: OrderHistoryPageContent(
      appBloc: appBloc,
    ));
  }
}

class OrderHistoryPageContent extends StatefulWidget {
  OrderHistoryPageContent({Key? key, required this.appBloc}) : super(key: key);

  final AppBloc appBloc;

  @override
  _OrderHistoryPageContentState createState() =>
      _OrderHistoryPageContentState();
}

class _OrderHistoryPageContentState extends State<OrderHistoryPageContent> {
  bool _isLoading = true;
  FirebaseManager? _firebaseManager;
  List<UserOrder> _orderHistoryList = [];
  AppLocalizations? _appLocalizations;

  @override
  void initState() {
    _firebaseManager = FirebaseManager();
    _isLoading = true;

    _getOrderHistory();
    super.initState();
  }

  _getOrderHistory() async {
    try {
      if (widget.appBloc != null) {
        _firebaseManager?.getOrderHistory().then((onValue) {
          if (onValue != null) {
            setState(() {
              _orderHistoryList =
                  UserOrder.fromDocumentSnapshotList(docList: onValue.docs);
              _isLoading = false;
            });
          }
          _stopLoading();
        }).catchError((onError) {
          Alert().requestFailwithMessage(
              context: context, message: onError.message);
          _stopLoading();
        });
      }
    } on PlatformException catch (error) {
      Alert().requestFailwithMessage(
          context: context, message: error.message ?? '');
      _stopLoading();
    }
  }

  _updateOrderHistoryOnOrderCancel() {
    _startLoading();
    _getOrderHistory();
  }

  _startLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  _stopLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context);
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              _appLocalizations!.translate(LocalizedKey.myOrderTitle),
              style: TextStyle(
                  fontSize: Screen.fontSize(size: 24), color: AppColor.darkRed),
            ),
          ),
          Container(
            height: 16,
          ),
          Expanded(
              child: _isLoading
                  ? Center(
                      child: Loader(
                      color: Colors.grey,
                    ))
                  : _orderHistoryList.length == 0
                      ? NoData(
                          message: _appLocalizations!
                              .translate(LocalizedKey.noOrderTitle))
                      : OrderHistoryPageList(
                          orderHistoryList: _orderHistoryList,
                          updateOrderHistoryIfReqiure:
                              _updateOrderHistoryOnOrderCancel,
                        ))
        ],
      ),
    );
  }
}
