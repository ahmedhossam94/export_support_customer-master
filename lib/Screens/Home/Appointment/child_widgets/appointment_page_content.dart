import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Screens/Home/Appointment/child_widgets/appointment_comment.dart';
import 'package:export_support_customer/Screens/Home/Appointment/child_widgets/appointment_continue_button.dart';
import 'package:export_support_customer/Screens/Home/Appointment/child_widgets/appointment_date.dart';
import 'package:export_support_customer/Screens/Home/Appointment/child_widgets/appointment_location.dart';
import 'package:flutter/material.dart';

class AppointmentPageContent extends StatelessWidget {
  AppointmentPageContent({Key? key, required this.isKeyboardShowing})
      : super(key: key);

  final bool isKeyboardShowing;

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BaseProvider.of<AppBloc>(context);

    List<Widget> widgetList = [
      AppointmentPageHeader(),
      AppointmentPageBody(),
      AppointmentPageComment(
        appBloc: appBloc,
      ),
    ];

    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: widgetList.length,
              itemBuilder: (_, index) => widgetList[index]),
        ),
        isKeyboardShowing ? Container() : AppointmentPageContinueButton(),
      ],
    ));
  }
}

class AppointmentPageHeader extends StatelessWidget {
  AppointmentPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Center(
          child: Text(
        localizations.translate(LocalizedKey.appointmentScreenHeaderTitle),
        style: TextStyle(
            fontSize: Screen.fontSize(size: 22), color: AppColor.darkRed),
      )),
    );
  }
}

class AppointmentPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16, left: 32, right: 32),
      child: Column(
        children: <Widget>[
          AppointmentDate(),
          Container(
            height: 8,
          ),
          AppointmentLocation(),
        ],
      ),
    );
  }
}
