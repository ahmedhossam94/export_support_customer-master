import 'dart:io';

import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/child_widgets/applied_service_add_new_service.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/child_widgets/applied_service_continue_button.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/child_widgets/applied_service_header.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/child_widgets/applied_service_images.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/child_widgets/applied_service_list.dart';
import 'package:export_support_customer/Screens/Home/MainPage/home_page.dart';
import 'package:flutter/material.dart';

class AppliedServicesContent extends StatefulWidget {
  AppliedServicesContent({Key? key}) : super(key: key);

  @override
  _AppliedServicesContentState createState() => _AppliedServicesContentState();
}

class _AppliedServicesContentState extends State<AppliedServicesContent> {
  AppBloc? _appBloc;
  List<Widget>? widgetList;
  int? _initialServiceListLength;
  SubmittedService? _initalLstSubmittedService;

  @override
  void initState() {
    _initialServiceListLength = 0;
    _initalLstSubmittedService = SubmittedService();

    widgetList = [
      AppliedServicesHeader(),
      AppliedServicesList(),
      AppliedServicesAddNewService(
        onTap: () {
          _onAddNewService();
        },
      ),
      AppliedServiceImages(
        onSelectImage: (imagesFile) {
          _onSelectImage(imagesFile);
        },
      )
    ];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAfterPageLoaded();
    });

    super.initState();
  }

  _initAfterPageLoaded() {
    _appBloc = BaseProvider.of<AppBloc>(context);
    _initialServiceListLength = _appBloc!.submittedOrder.services?.length;
    _initalLstSubmittedService = _appBloc!.submittedOrder.services?.last;
  }

  Future<bool> _onBackButtonTapped() {
    final List<SubmittedService>? submittedServiceList =
        _appBloc?.submittedOrder.services;
    if (submittedServiceList != null && submittedServiceList.length > 0) {
      final int lastIndex = submittedServiceList.length - 1;
      final bool isLast =
          _initalLstSubmittedService == submittedServiceList.last;

      if (submittedServiceList.length == _initialServiceListLength && isLast) {
        _appBloc!.submittedOrder.services?.removeAt(lastIndex);
      }
    }
    return Future<bool>.value(true);
  }

  _onAddNewService() {
    _appBloc?.isAddNewService = true;
    Common.instance.notavigateTo(
        page: HomePage(
          isInNavigationStack: true,
        ),
        pageName: "HomePage",
        context: context);
  }

  _onSelectImage(List<File> imagesFile) {
    _appBloc?.submittedOrder.images = imagesFile;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonTapped(),
      child: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: widgetList?.length,
                  itemBuilder: (_, index) => widgetList![index]),
            ),
            AppliedServiceContinueButton()
          ],
        ),
      ),
    );
  }
}
