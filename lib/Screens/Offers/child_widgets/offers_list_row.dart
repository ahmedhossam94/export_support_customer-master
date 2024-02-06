import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/offer_status.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/offers_model.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/applied_services.dart';
import 'package:export_support_customer/SharedWisget/common_button.dart';
import 'package:flutter/material.dart';

class OffersListRowHeader extends StatelessWidget {
  OffersListRowHeader({Key? key, required this.offer}) : super(key: key);

  final OffersModel offer;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    bool isArabic = localizations.isArabic();

    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      color: AppColor.darkGray,
      child: Text(
        isArabic ? offer.titleAr : offer.titleEn,
        style:
            TextStyle(fontSize: Screen.fontSize(size: 24), color: Colors.white),
      ),
    );
  }
}

class OffersListRowBdoy extends StatelessWidget {
  OffersListRowBdoy({Key? key, required this.offer}) : super(key: key);

  final OffersModel offer;

  _onOrderOffer(BuildContext context) {
    SubmittedService submittedService;
    AppBloc appBloc = BaseProvider.of<AppBloc>(context);

    if (offer.offerType == null || offer.offerType == OfferType.services) {
      submittedService = _getSubmittedServiceOnServiceOffer(appBloc);
    } else {
      submittedService = _getSubmittedServiceOnPackagesOffer();
    }

    if (submittedService != null) {
      if (appBloc.submittedOrder.services == null) {
        appBloc.submittedOrder.services = []; //List<SubmittedService>();
      }
      appBloc.submittedOrder.services?.add(submittedService);

      _navigateToAppliedServiceScreen(appBloc, context);
    } else {
      print("There is no submitted order to procced");
    }
  }

  SubmittedService _getSubmittedServiceOnServiceOffer(AppBloc appBloc) {
    SubmittedService submittedService = SubmittedService();
    MainService mainService = _getMainService(appBloc);
    SubMainService subMainService = _getSubMainService(mainService);

    if (mainService == null || (mainService.hasSub && subMainService == null)) {
      throw '';
    }

    bool hasSub = mainService.hasSub;

    submittedService.serviceCategoryId = offer.serviceCategoryID;
    submittedService.mainServiceId = offer.mainServiceID;
    submittedService.subMainServiceId = hasSub ? offer.subMainServiceID : "";
    submittedService.isSubService = hasSub;
    submittedService.nameAr =
        mainService.nameAr + (hasSub ? " - " + subMainService.nameAr : "");
    submittedService.nameEn =
        mainService.nameEn + (hasSub ? " - " + subMainService.nameEn : "");
    submittedService.priceForOnePiece =
        hasSub ? subMainService.price : mainService.price;

    submittedService.hasOffer = true;
    submittedService.offerType = OfferType.services;
    submittedService.offerNameAr = offer.titleAr;
    submittedService.offerNameEn = offer.titleEn;
    submittedService.offerDescAr = offer.descAr;
    submittedService.offerDescEn = offer.descEn;
    submittedService.offerServiceDetailsAr = "";
    submittedService.offerServiceDetailsEn = "";
    submittedService.offerQuantity = offer.qauntity;
    submittedService.offerPrice = offer.priceForOne;

    num servicePrice = hasSub ? subMainService.price : mainService.price;
    num price = offer.qauntity <= submittedService.quantity
        ? offer.priceForOne
        : servicePrice;
    submittedService.totalPrice = price * submittedService.quantity;

    return submittedService;
  }

  MainService _getMainService(AppBloc appBloc) {
    List<ServiceCatagory> serviceList = appBloc.services.serviceList;

    MainService mainService = serviceList
        .firstWhere((s) => s.id == offer.serviceCategoryID, orElse: null)
        .serviceTypeList
        .firstWhere((s) => s.id == offer.serviceTypeID, orElse: null)
        .mainServiceList
        .firstWhere((s) => s.id == offer.mainServiceID, orElse: null);

    return mainService;
  }

  SubMainService _getSubMainService(MainService mainService) {
    if (mainService == null || !mainService.hasSub) {
      throw '';
    }

    return mainService.subMainServiceList
        .firstWhere((s) => s.id == offer.subMainServiceID, orElse: null);
  }

  SubmittedService _getSubmittedServiceOnPackagesOffer() {
    SubmittedService submittedService = SubmittedService();
    submittedService.serviceCategoryId = "";
    submittedService.mainServiceId = "";
    submittedService.subMainServiceId = "";
    submittedService.isSubService = false;
    submittedService.nameAr = "";
    submittedService.nameEn = "";
    submittedService.priceForOnePiece = 0.0;

    submittedService.hasOffer = true;
    submittedService.offerType = OfferType.packages;
    submittedService.offerNameAr = offer.titleAr;
    submittedService.offerNameEn = offer.titleEn;
    submittedService.offerDescAr = offer.descAr;
    submittedService.offerDescEn = offer.descEn;
    submittedService.offerServiceDetailsAr = offer.serviceDetailsAr;
    submittedService.offerServiceDetailsEn = offer.serviceDetailsEn;
    submittedService.offerQuantity = 1;
    submittedService.offerPrice = offer.priceForOne;
    submittedService.totalPrice = offer.priceForOne;

    return submittedService;
  }

  _navigateToAppliedServiceScreen(AppBloc appBloc, BuildContext context) {
    if (appBloc.isAddNewService) {
      appBloc.isAddNewService = false;
      // Navigator.of(context).popUntil(
      //   ModalRoute.withName("AppliedServices")
      // );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => AppliedServices()),
          ModalRoute.withName("AppliedServices"));
    } else {
      Common.instance.notavigateTo(
          page: AppliedServices(),
          pageName: "AppliedServices",
          context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    bool isArabic = localizations.isArabic();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.darkGray, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              isArabic ? offer.descAr : offer.descEn,
              style: TextStyle(fontSize: Screen.fontSize(size: 22)),
            ),
          ),
          Container(
            height: 16,
          ),
          CommonButton(
              title: localizations.translate(LocalizedKey.orderNowButtonTitle),
              onPressed: () {
                _onOrderOffer(context);
              })
        ],
      ),
    );
  }
}
