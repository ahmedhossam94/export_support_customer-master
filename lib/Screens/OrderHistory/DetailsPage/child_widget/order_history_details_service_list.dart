import 'package:export_support_customer/Models/user_order.dart';
import 'package:export_support_customer/SharedWisget/OrderInfo/order_info_service.dart';
import 'package:flutter/material.dart';

class OrderHistoryDetailsPageContentSeviceList extends StatelessWidget {
  OrderHistoryDetailsPageContentSeviceList({Key? key, required this.services})
      : super(key: key);

  final List<UserOrderService> services;

  bool _isPackagesOffer(UserOrderService service) {
    return service.isPackageOffer != null && service.isPackageOffer;
  }

  String _getServiceDetailsAr(UserOrderService service) {
    return _isPackagesOffer(service) ? service.offerServiceDetailsAr : "";
  }

  String _getServiceDetailsEn(UserOrderService service) {
    return _isPackagesOffer(service) ? service.offerServiceDetailsEn : "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: services.length,
          itemBuilder: (_, index) {
            UserOrderService service = services[index];
            return OrderInfoService(
              quantity: service.quantity.toString(),
              serviceCategoryId: service.serviceCategoryId,
              serviceNameAr: service.nameAr ?? "",
              serviceNameEn: service.nameEn ?? "",
              totalPrice: service.totalPrice.toString() ?? "",
              isNeededPasts: service.neededParts,
              isPackagesOffer: _isPackagesOffer(service),
              serviceDetailsAr: _getServiceDetailsAr(service),
              serviceDetailsEn: _getServiceDetailsEn(service),
            );
          }),
    );
  }
}
