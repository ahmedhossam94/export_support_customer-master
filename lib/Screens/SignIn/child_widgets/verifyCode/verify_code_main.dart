import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/BlocResources/login_bloc.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class VerifyCode extends StatefulWidget {
  VerifyCode(
      {Key? key,
      required this.onVerifyCode,
      required this.onResendVerifyCode,
      this.resendCountdown = 0})
      : super(key: key);
  final VoidCallback onVerifyCode;
  final VoidCallback onResendVerifyCode;
  final int resendCountdown;

  @override
  _VerifyCodeState createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final TextEditingController verifyCodeController = TextEditingController();
  LoginBloc? _loginBloc;
  AppLocalizations? _localizations;

  bool _isValidVerifyCode() {
    bool hasCode = verifyCodeController.text.isNotEmpty;
    if (!hasCode) {
      Alert().warning(
          context: context,
          message: _localizations!
              .translate(LocalizedKey.noVerifyCodeEnterAlertMessage),
          onPressed: () {
            Common.instance.dismiss(context);
          });
    }

    return hasCode;
  }

  _handleVerifyCode() {
    try {
      if (_isValidVerifyCode()) {
        widget.onVerifyCode();
      }
    } catch (error) {
      print(error.toString());
    }
  }

  _handleResendVerifcationCode() {
    try {
      widget.onResendVerifyCode();
    } catch (error) {
      print(error.toString());
      throw '';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = BaseProvider.of<LoginBloc>(context);
    _localizations = AppLocalizations.of(context);
    bool isCountdownEnd = widget.resendCountdown < 1;
    String resendButtonTitle = isCountdownEnd
        ? _localizations!.translate(LocalizedKey.resendCodeTitle)
        : "${_localizations!.translate(LocalizedKey.resendCodeInTitle)} ${widget.resendCountdown} ${_localizations!.translate(LocalizedKey.seconds)}";

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Center(
          child: Column(
        children: <Widget>[
          Text(
            "${_localizations!.translate(LocalizedKey.verifyCodeSendToTitle)}\n${_loginBloc?.phoneForDisplay}",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: Screen.fontSize(size: 20), color: Colors.black),
          ),
          Container(
            height: 16,
          ),
          VerifyCodeTextField(
            controller: verifyCodeController,
          ),
          Container(
            height: 16,
          ),
          VerifyCodeButton(
            onPressed: _handleVerifyCode,
          ),
          Container(
            height: 8,
          ),
          ResendVerifyCodeButton(
              title: resendButtonTitle,
              onPressed:
                  (isCountdownEnd ? _handleResendVerifcationCode : () {})),
        ],
      )),
    );
  }
}

class VerifyCodeTextField extends StatelessWidget {
  VerifyCodeTextField({Key? key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BaseProvider.of<LoginBloc>(context);
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        color: Colors.white,
        child: StreamBuilder<String>(
            stream: _loginBloc.code,
            builder: (context, snapshot) {
              return TextField(
                onChanged: _loginBloc.codeChange,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: Screen.fontSize(size: 18)),
                controller: controller,
                decoration: InputDecoration.collapsed(
                  hintText:
                      localizations.translate(LocalizedKey.verifyCodeHintTitle),
                ),
              );
            }));
  }
}

class VerifyCodeButton extends StatelessWidget {
  VerifyCodeButton({Key? key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColor.darkRed)),
          onPressed: onPressed,
          child: Text(
            localizations.translate(LocalizedKey.verifyCodeButtonTitle),
            style: TextStyle(
                fontSize: Screen.fontSize(size: 20), color: Colors.white),
          ),
        ));
  }
}

class ResendVerifyCodeButton extends StatelessWidget {
  ResendVerifyCodeButton(
      {Key? key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(
                fontSize: Screen.fontSize(size: 20), color: Colors.black),
          ),
        ));
  }
}
