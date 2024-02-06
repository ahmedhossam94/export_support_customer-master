import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class AppointmentPageComment extends StatefulWidget {
  AppointmentPageComment({Key? key, required this.appBloc}) : super(key: key);

  final AppBloc appBloc;

  @override
  _AppointmentPageCommentState createState() => _AppointmentPageCommentState();
}

class _AppointmentPageCommentState extends State<AppointmentPageComment> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller =
        TextEditingController(text: widget.appBloc.submittedOrder.comment);
    super.initState();
  }

  _onCommentChange(String value) {
    widget.appBloc.submittedOrder.comment = value;
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.only(bottom: 16, left: 32, right: 32),
      child: Column(
        children: <Widget>[
          Center(
              child: Text(
            localizations.translate(LocalizedKey.additionalDetailsTitle),
            style: TextStyle(
                fontSize: Screen.fontSize(size: 20), color: AppColor.darkRed),
          )),
          Container(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              onChanged: _onCommentChange,
              style: TextStyle(fontSize: Screen.fontSize(size: 18)),
              maxLength: 300,
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: localizations
                      .translate(LocalizedKey.additionalDetailsHintTitle),
                  hintStyle: TextStyle(fontSize: Screen.fontSize(size: 18)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black))),
            ),
          ),
        ],
      ),
    );
  }
}
