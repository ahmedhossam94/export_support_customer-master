import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/BlocResources/login_bloc.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInPhoneTextField extends StatelessWidget {
  SignInPhoneTextField(
      {Key? key, required this.controller, this.isEnabled = true});

  final bool isEnabled;
  final TextEditingController controller;
  final TextEditingController phoneCodeController =
      TextEditingController(text: "+966");

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BaseProvider.of<LoginBloc>(context);
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: <Widget>[
          localizations.isArabic()
              ? Container()
              : CodeTextField(
                  controller: phoneCodeController,
                ),
          Container(
            width: 4,
          ),
          Expanded(
            child: StreamBuilder<String>(
                stream: _loginBloc.phone,
                builder: (context, snapshot) {
                  return TextField(
                    enabled: isEnabled,
                    onChanged: _loginBloc.phoneChange,
                    keyboardType: TextInputType.phone,
                    textAlign: localizations.isArabic()
                        ? TextAlign.end
                        : TextAlign.start,
                    style: TextStyle(fontSize: Screen.fontSize(size: 20)),
                    controller: controller,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration.collapsed(
                      hintText: localizations
                          .translate(LocalizedKey.phoneNumberHintTitle),
                    ),
                  );
                }),
          ),
          Container(
            width: 4,
          ),
          localizations.isArabic()
              ? CodeTextField(
                  controller: phoneCodeController,
                )
              : Container(),
        ],
      ),
    );
  }
}

class CodeTextField extends StatelessWidget {
  CodeTextField({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screen.screenWidth * 0.12,
      child: TextField(
        enabled: false,
        controller: controller,
        textDirection: TextDirection.ltr,
        style: TextStyle(fontSize: Screen.fontSize(size: 20)),
        decoration: InputDecoration.collapsed(hintText: ""),
      ),
    );
  }
}

class SignInNameTextField extends StatelessWidget {
  SignInNameTextField({Key? key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BaseProvider.of<LoginBloc>(context);
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: StreamBuilder<Object>(
          stream: _loginBloc.name,
          builder: (context, snapshot) {
            return TextField(
              onChanged: _loginBloc.nameChange,
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: Screen.fontSize(size: 20)),
              controller: controller,
              decoration: InputDecoration.collapsed(
                hintText: localizations.translate(LocalizedKey.nameHintTitle),
              ),
            );
          }),
    );
  }
}
