import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/offer_status.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/SharedWisget/OrderInfo/order_info_service.dart';
import 'package:flutter/material.dart';

class SummaryPageContentSeviceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BaseProvider.of<AppBloc>(context);
    List<SubmittedService>? services = appBloc.submittedOrder.services;

    bool _isPackagesOffer(SubmittedService service) {
      return service.hasOffer && service.offerType == OfferType.packages;
    }

    String? _getNameAr(SubmittedService service) {
      return _isPackagesOffer(service)
          ? service.offerNameAr
          : service.nameAr ?? "";
    }

    String? _getNameEn(SubmittedService service) {
      return _isPackagesOffer(service)
          ? service.offerNameEn
          : service.nameEn ?? "";
    }

    String? _getServiceDetailsAr(SubmittedService service) {
      return _isPackagesOffer(service) ? service.offerServiceDetailsAr : "";
    }

    String? _getServiceDetailsEn(SubmittedService service) {
      return _isPackagesOffer(service) ? service.offerServiceDetailsEn : "";
    }

    return Container(
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: services?.length,
          itemBuilder: (_, index) {
            SubmittedService service = appBloc.submittedOrder.services![index];

            return OrderInfoService(
              quantity: service.quantity.toString(),
              serviceCategoryId: service.serviceCategoryId ?? '',
              serviceNameAr: _getNameAr(service) ?? '',
              serviceNameEn: _getNameEn(service) ?? '',
              totalPrice: service.totalPrice.toString() ?? "",
              isNeededPasts: service.neededParts,
              isPackagesOffer: _isPackagesOffer(service),
              serviceDetailsAr: _getServiceDetailsAr(service) ?? '',
              serviceDetailsEn: _getServiceDetailsEn(service) ?? '',
            );
          }),
    );
  }
}
