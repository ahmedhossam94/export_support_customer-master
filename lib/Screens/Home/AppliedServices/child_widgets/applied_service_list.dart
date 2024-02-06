import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/offer_status.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/child_widgets/applied_service_list_content.dart';
import 'package:flutter/material.dart';

class AppliedServicesList extends StatefulWidget {
  AppliedServicesList({Key? key}) : super(key: key);

  @override
  _AppliedServicesListState createState() => _AppliedServicesListState();
}

class _AppliedServicesListState extends State<AppliedServicesList> {
  AppBloc? _appBloc;

  @override
  void initState() {
    super.initState();
  }

  _onRemoveService(int index) {
    setState(() {
      _appBloc!.submittedOrder.services?.removeAt(index);
    });
    print(
        "current services applied list size ${_appBloc!.submittedOrder.services?.length}");
  }

  _onChangeServiceQuantity(int quantity, int index) {
    bool isOfferPrice = _appBloc!.submittedOrder.services![index].hasOffer &&
        _appBloc!.submittedOrder.services![index].offerQuantity! <= quantity;
    num? price = isOfferPrice
        ? _appBloc!.submittedOrder.services![index].offerPrice
        : _appBloc!.submittedOrder.services?[index].priceForOnePiece;

    setState(() {
      _appBloc?.submittedOrder.services?[index].quantity = quantity;
      _appBloc?.submittedOrder.services?[index].totalPrice =
          (price! * quantity);
    });
  }

  _onChangeSerivceNeededParts(bool isChecked, int index) {
    _appBloc?.submittedOrder.services?[index].neededParts = isChecked;
  }

  @override
  Widget build(BuildContext context) {
    _appBloc = BaseProvider.of<AppBloc>(context);
    final submittedServices = _appBloc!.submittedOrder.services;
    return Container(
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: submittedServices!.length,
          itemBuilder: (_, index) {
            SubmittedService submittedService = submittedServices[index];

            return Container(
              child: Column(
                children: <Widget>[
                  AppliedServicesListContentHeader(
                    submittedService: submittedService,
                  ),
                  AppliedServicesListContentBody(
                    onRemove: () => _onRemoveService(index),
                    qauntity: submittedServices[index].quantity.toInt(),
                    onQuantityChange: (quantity) =>
                        _onChangeServiceQuantity(quantity, index),
                    neededParts: submittedServices[index].neededParts,
                    onNeededPartsChange: (isChecked) =>
                        _onChangeSerivceNeededParts(isChecked, index),
                    dropdownButtonEnabled: !(submittedService.hasOffer &&
                        submittedService.offerType == OfferType.packages),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
