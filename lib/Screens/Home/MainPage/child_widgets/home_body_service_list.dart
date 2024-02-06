import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:export_support_customer/Screens/Home/ServiceType/service_type_page.dart';
import 'package:export_support_customer/Screens/Offers/offers_page.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  final List<ServiceCatagory> serviceList;
  CategoryList({Key? key, required this.serviceList}) : super(key: key);

  _isServiceAvailable(ServiceCatagory service) {
    return service.isActive ||
        service.id == ServiceCatagoryID.airConditioner ||
        service.id == ServiceCatagoryID.electric ||
        service.id == ServiceCatagoryID.plumbing ||
        service.serviceTypeList.isNotEmpty;
  }

  _onServiceItemTaped(int index, BuildContext context) {
    final service = serviceList[index];
    if (!_isServiceAvailable(service)) {
      Alert().serviceNotAvailable(
          context: context,
          serviceCategoryID: service.id,
          serviceCategoryNameAr: service.nameAr,
          serviceCategoryNameEn: service.nameEn);
    } else {
      Common.instance.notavigateTo(
          page: ServiceTypePage(
            serviceCatagory: service,
          ),
          pageName: "ServiceTypePage",
          context: context);
    }
  }

  _onDealsItemTapped(BuildContext context) {
    Common.instance.notavigateTo(
        page: OffersPage(), pageName: "ServiceTypePage", context: context);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.95,
      ),
      padding: EdgeInsets.all(8),
      itemBuilder: (_, index) {
        final isDeals = index == 0;
        return GestureDetector(
          child: CatagoryListContent(
            serviceCatagory: serviceList[index - 1],
            isDeals: isDeals,
          ),
          onTap: () {
            isDeals
                ? _onDealsItemTapped(context)
                : _onServiceItemTaped(index - 1, context);
          },
        );
      },
      itemCount: serviceList.length + 1,
    );
  }
}

class CatagoryListContent extends StatelessWidget {
  final ServiceCatagory serviceCatagory;
  final bool isDeals;
  CatagoryListContent(
      {Key? key, required this.serviceCatagory, required this.isDeals})
      : assert((serviceCatagory != null && !isDeals) ||
            (serviceCatagory == null && isDeals)),
        super(key: key);

  String get _imageName => isDeals
      ? Common.instance.getDealHomePageIconName()
      : Common.instance.getServiceCategoryIconName(serviceCatagory.id);

  String _getCategoryName(AppLocalizations localizations) {
    if (isDeals) {
      return localizations.translate(LocalizedKey.dealTitle);
    }

    return localizations.isArabic()
        ? serviceCatagory.nameAr
        : serviceCatagory.nameEn;
  }

  bool isFullOpactiy() {
    return isDeals ||
        (serviceCatagory.isActive &&
            (serviceCatagory.id == ServiceCatagoryID.airConditioner ||
                serviceCatagory.id == ServiceCatagoryID.electric ||
                serviceCatagory.id == ServiceCatagoryID.plumbing)) ||
        serviceCatagory.id == ServiceCatagoryID.onlineShop;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(4),
      child: Column(
        children: <Widget>[
          Container(
            height: Screen.screenWidth * 0.18,
            child: Opacity(
                opacity: isFullOpactiy() ? 1 : 0.5,
                child: Center(
                    child: Image(
                  image: AssetImage(_imageName),
                  fit: BoxFit.fitHeight,
                ))),
          ),
          Container(
            height: 8,
          ),
          Container(
            child: Center(
                child: Text(
              _getCategoryName(localizations),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: Screen.fontSize(size: Screen.fontSize(size: 20))),
            )),
          )
        ],
      ),
    );
  }
}
