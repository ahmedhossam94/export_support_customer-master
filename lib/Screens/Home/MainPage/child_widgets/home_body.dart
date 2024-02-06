import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/Screens/Home/MainPage/child_widgets/home_body_service_list.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BaseProvider.of<AppBloc>(context);
    if (appBloc.services.serviceList == null ||
        appBloc.services.serviceList.length > 0) {
      return CategoryList(
        serviceList: appBloc.services.serviceList,
      );
    }
    return Container();
  }
}
