import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/BlocResources/submitted_order_bloc.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/offer.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/applied_services.dart';
import 'package:flutter/material.dart';

class MainServiceListWithSubList extends StatefulWidget {
  final String serviceID;
  final MainService mainService;
  final int itemIndex;
  final int selectedItem;
  final Function(bool) onItemTapped;
  MainServiceListWithSubList(
      {Key? key,
      required this.serviceID,
      required this.mainService,
      required this.itemIndex,
      required this.selectedItem,
      required this.onItemTapped})
      : super(key: key);

  @override
  _MainServiceListWithSubListState createState() =>
      _MainServiceListWithSubListState();
}

class _MainServiceListWithSubListState
    extends State<MainServiceListWithSubList> {
  String _serviceID = '';
  bool _isExpanded = false;
  MainService? _mainService;
  int _itemIndex = 0;
  SubmittedOrderBloc? _submittedOrderBloc;
  AppBloc? _appBloc;

  @override
  void initState() {
    _serviceID = widget.serviceID;
    _isExpanded = false;
    _mainService = widget.mainService;
    _itemIndex = widget.itemIndex;
    _submittedOrderBloc = SubmittedOrderBloc();

    super.initState();
  }

  Widget _acTypeImageWidget() {
    String imageName = Common.instance.getACTypeImage(_mainService!.type);
    return imageName != ""
        ? Image(
            image:
                AssetImage(Common.instance.getACTypeImage(_mainService!.type)),
            height: Screen.screenWidth * .16,
            width: Screen.screenWidth * .1,
          )
        : Container(
            height: Screen.screenWidth * .16,
            width: Screen.screenWidth * .1,
          );
  }

  Widget _expandedImageWidget(String image) {
    return Image(
      image: AssetImage(
        image,
      ),
      height: Screen.screenWidth * 0.065,
      width: Screen.screenWidth * 0.06,
    );
  }

  _onExpandedStatusChange(value) {
    setState(() {
      _isExpanded = value;
      widget.onItemTapped(value);
    });
  }

  List<Widget> _subMainServiceList() {
    return widget.mainService.subMainServiceList.map((sub) {
      int index = _mainService!.subMainServiceList.indexOf(sub);
      return GestureDetector(
          onTap: () => _onSubItemTapped(index),
          child: SubMainServiceList(
            subMainService: sub,
            index: index,
          ));
    }).toList();
  }

  _onSubItemTapped(int index) async {
    SubmittedService submittedService = SubmittedService();
    MainService mainService = widget.mainService;
    SubMainService subMainService =
        widget.mainService.subMainServiceList[index];

    Common.instance.loading(context);

    Offer offer = await _submittedOrderBloc!.getOfferIfAvaible(
        mainServiceID: mainService.id,
        subMainSerivceID: subMainService.id,
        isSub: mainService.hasSub);

    if (offer != null) {
      submittedService.hasOffer = true;
      submittedService.offerQuantity = offer.quantity;
      submittedService.offerPrice = offer.price;
    }

    submittedService.serviceCategoryId = _serviceID;
    submittedService.mainServiceId = mainService.id;
    submittedService.subMainServiceId = subMainService.id;
    submittedService.isSubService = mainService.hasSub;
    submittedService.nameAr =
        mainService.nameAr + " - " + subMainService.nameAr;
    submittedService.nameEn =
        mainService.nameEn + " - " + subMainService.nameEn;
    submittedService.priceForOnePiece = subMainService.price;
    submittedService.totalPrice =
        subMainService.price * submittedService.quantity;

    if (_appBloc!.submittedOrder.services == null) {
      _appBloc!.submittedOrder.services = [];
    }
    _appBloc!.submittedOrder.services?.add(submittedService);

    Common.instance.dismiss(context);

    if (_appBloc!.isAddNewService) {
      _appBloc!.isAddNewService = false;
      //Navigator.of(context).popUntil(ModalRoute.withName("AppliedServices"));
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
    _appBloc = BaseProvider.of<AppBloc>(context);
    AppLocalizations localizations = AppLocalizations.of(context);
    bool isArabic = localizations.isArabic();

    final String expandedImage =
        _isExpanded ? ImageName.upArrow : ImageName.downArrow;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      color: AppColor.lightDarkGray,
      child: ExpansionTile(
        key: Key(_itemIndex.toString()),
        initiallyExpanded: _itemIndex == widget.selectedItem,
        leading: _acTypeImageWidget(),
        trailing: _expandedImageWidget(expandedImage),
        title: Text(isArabic ? _mainService!.nameAr : _mainService!.nameEn,
            style: TextStyle(
              color: Colors.white,
              fontSize: Screen.fontSize(size: 22),
            )),
        onExpansionChanged: _onExpandedStatusChange,
        children: _subMainServiceList(),
      ),
    );
  }
}

class SubMainServiceList extends StatelessWidget {
  final SubMainService subMainService;
  final int index;
  SubMainServiceList(
      {Key? key, required this.subMainService, required this.index})
      : super(key: key);

  bool _isEmptyName(bool isArabic) {
    return isArabic
        ? (subMainService.nameAr == "")
        : (subMainService.nameEn == "");
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);
    bool isArabic = localizations.isArabic();

    return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  !_isEmptyName(isArabic)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              isArabic
                                  ? subMainService.nameAr
                                  : subMainService.nameEn,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Screen.fontSize(size: 22)),
                            ),
                            Container(
                              height: 4,
                            )
                          ],
                        )
                      : Container(),
                  Text(
                    "${subMainService.price} ${localizations.translate(LocalizedKey.riyal_text)} " +
                        (isArabic
                            ? subMainService.priceDescAr
                            : subMainService.priceDescEn),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Screen.fontSize(size: 20)),
                  )
                ],
              ),
            ),
            Container(
              width: 16,
            ),
            Image(
              image: AssetImage(
                isArabic ? ImageName.leftArrow : ImageName.rightArrow,
              ),
              height: Screen.screenWidth * 0.065,
              width: Screen.screenWidth * 0.06,
            )
          ],
        ));
  }
}
