import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/BlocResources/submitted_order_bloc.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Models/general_details.dart';
import 'package:export_support_customer/Models/offer.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/applied_services.dart';
import 'package:export_support_customer/Screens/Home/MainService/child_widgets/main_service_body_list.dart';
import 'package:export_support_customer/Screens/Home/MainService/child_widgets/main_service_body_list_with_sub_list.dart';
import 'package:flutter/material.dart';

class MainServiceBody extends StatefulWidget {
  final String serviceID;
  final List<MainService> mainServiceList;
  MainServiceBody(
      {Key? key, required this.serviceID, required this.mainServiceList})
      : super(key: key);

  @override
  _MainServiceBodyState createState() => _MainServiceBodyState();
}

class _MainServiceBodyState extends State<MainServiceBody> {
  String _serviceID = '';
  List<MainService> _mainServiceList = [];
  int _selectedItem = 0;
  SubmittedOrderBloc? _submittedOrderBloc;
  AppBloc? _appBloc;
  SubmitOrder? _submittedOrder;
  bool _isArabic = false;

  @override
  void initState() {
    _serviceID = widget.serviceID;
    _mainServiceList = widget.mainServiceList;
    _selectedItem = -1;
    _submittedOrderBloc = SubmittedOrderBloc();

    super.initState();
  }

  onExpandedItemTapped(bool isExpanded, int index) {
    setState(() {
      if (isExpanded) {
        Duration(seconds: 20000);
        _selectedItem = index;
      } else {
        _selectedItem = -1;
      }
    });
  }

  onItemTapped(int index) async {
    SubmittedService submittedService = SubmittedService();
    MainService mainService = _mainServiceList[index];

    Common.instance.loading(context);

    Offer offer = await _submittedOrderBloc!.getOfferIfAvaible(
        mainServiceID: mainService.id,
        subMainSerivceID: null,
        isSub: mainService.hasSub);

    if (offer != null) {
      submittedService.hasOffer = true;
      submittedService.offerQuantity = offer.quantity;
      submittedService.offerPrice = offer.price;
    }

    submittedService.serviceCategoryId = _serviceID;
    submittedService.mainServiceId = mainService.id;
    submittedService.subMainServiceId = "";
    submittedService.isSubService = mainService.hasSub;
    submittedService.nameAr = mainService.nameAr;
    submittedService.nameEn = mainService.nameEn;
    submittedService.priceForOnePiece = mainService.price;
    submittedService.totalPrice = mainService.price * submittedService.quantity;

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
    _isArabic = AppLocalizations.of(context).isArabic();
    _submittedOrder = _appBloc!.generalDetails.submitOrder;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _submittedOrder!.canShowVatNote
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(_isArabic
                      ? _submittedOrder!.vatPriceNoteAr
                      : _submittedOrder!.vatPriceNoteEn),
                )
              : Container(),
          Expanded(
            child: ListView.builder(
                key: Key('builder ${_selectedItem.toString()}'),
                itemCount: widget.mainServiceList.length,
                itemBuilder: (context, index) {
                  final mainService = _mainServiceList[index];
                  return !mainService.hasSub
                      ? GestureDetector(
                          onTap: () => onItemTapped(index),
                          child: MainServiceBodyList(
                            mainService: mainService,
                          ))
                      : MainServiceListWithSubList(
                          serviceID: _serviceID,
                          mainService: mainService,
                          itemIndex: index,
                          selectedItem: _selectedItem,
                          onItemTapped: (value) {
                            onExpandedItemTapped(value, index);
                          },
                        );
                }),
          ),
        ],
      ),
    );
  }
}
