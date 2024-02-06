import 'dart:io';

import 'package:export_support_customer/FirebaseResources/firebase_manager.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/delegates.dart';
import 'package:export_support_customer/HelperClass/order_status.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/user_order.dart';
import 'package:export_support_customer/Screens/OrderHistory/DetailsPage/child_widget/order_history_details_body.dart';
import 'package:export_support_customer/Screens/OrderHistory/DetailsPage/child_widget/order_history_details_header.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/loader.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' as Geocoder;

class OrderHistoryDetailsPage extends StatelessWidget {
  static const String route = "/OrderHistoryDetailsPage";

  OrderHistoryDetailsPage(
      {Key? key, required this.order, required this.orderHistoryDelegate})
      : super(key: key);

  final UserOrder order;
  final OrderHistoryDelegate orderHistoryDelegate;

  final FirebaseManager _firebaseManager = FirebaseManager();

  List<Widget> appBarActions(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    return [
      ElevatedButton(
          child: Text(
              localizations.translate(LocalizedKey.cancelOrderAppbarTitle)),
          onPressed: () {
            Alert().conformation(
                context: context,
                title: localizations
                    .translate(LocalizedKey.cancelOrderConformationAlertTitle),
                message: localizations.translate(
                    LocalizedKey.cancelOrderConformationAlertMessage),
                okActionPressed: () {
                  Common.instance.dismiss(context);
                  _cancelOrder(context);
                });
          })
    ];
  }

  _cancelOrder(BuildContext context) {
    try {
      AppLocalizations localizations = AppLocalizations.of(context);
      Common.instance.loading(context);

      _firebaseManager.cancelOrder(order: order).then((_) {
        Common.instance.dismiss(context);
        Alert().success(
            context: context,
            message: localizations
                .translate(LocalizedKey.succussCancelOrderAlertMessage),
            onPressed: () {
              Common.instance.dismiss(context);
              orderHistoryDelegate.isReqiureUpdate(true);
              Common.instance.dismiss(context);
            });
      }).catchError((e) {
        Common.instance.dismiss(context);
        Alert().requestFailwithMessage(context: context, message: e.message);
      });
    } on PlatformException catch (e) {
      Common.instance.dismiss(context);
      Alert()
          .requestFailwithMessage(context: context, message: e.message ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundContainer(
      child: Scaffold(
        appBar: order.orderStatus == OrderStatus.pending
            ? CustomAppBar(actions: appBarActions(context))
            : CustomAppBar(),
        backgroundColor: Colors.transparent,
        body: OrderHistoryDetailsPageContent(
          order: order,
        ),
      ),
    );
  }
}

class OrderHistoryDetailsPageContent extends StatefulWidget {
  OrderHistoryDetailsPageContent({Key? key, required this.order})
      : super(key: key);

  final UserOrder order;

  @override
  _OrderHistoryDetailsPageContentState createState() =>
      _OrderHistoryDetailsPageContentState();
}

class _OrderHistoryDetailsPageContentState
    extends State<OrderHistoryDetailsPageContent> {
  String? _address;
  bool _isSettingAddress = false;

  @override
  void initState() {
    _address = "";
    _isSettingAddress = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setAddress();
    });
    super.initState();
  }

  _setAddress() {
    var geocoderCoordinate = Geocoder.placemarkFromCoordinates(
        widget.order.coordinate.latitude ?? 0,
        widget.order.coordinate.longitude ?? 0);

    // Geocoder
    //   .Geocoder
    //   .local
    //   .findAddressesFromCoordinates(geocoderCoordinate)
    //   .then((addressList) {
    //     if (addressList.length > 0 && addressList.first != null) {
    //       String streetNumber =
    //         addressList.first.subThoroughfare == null
    //         ? addressList.first.featureName
    //         : addressList.first.subThoroughfare;

    //       String streetName =
    //         addressList.first.thoroughfare == null
    //         ? ""
    //         : " ${addressList.first.thoroughfare}";

    //       String district =
    //         addressList.first.subLocality == null
    //         ? ""
    //         : ", ${addressList.first.subLocality}";

    //       String city =
    //         addressList.first.locality == null
    //         ? "" :
    //         ", ${addressList.first.locality}";

    //         _address = streetNumber + streetName + district + city;
    //     } else {
    //       _address = "${widget.order.coordinate.latitude}, ${widget.order.coordinate.longitude}";
    //     }

    //     setState(() {
    //       _isSettingAddress = false;
    //     });
    //   }).catchError((onError) {
    //     _address = "";
    //     setState(() {
    //       _isSettingAddress = false;
    //     });
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: Platform.isIOS ? 24 : 16),
        child: _isSettingAddress
            ? Center(
                child: Loader(
                color: Colors.grey,
              ))
            : SingleChildScrollView(
                child: Column(children: <Widget>[
                  OrderHistoryDetailsHeader(),
                  OrderHistoryDetailsBody(
                    order: widget.order,
                    address: _address ?? '',
                  ),
                ]),
              ));
  }
}
