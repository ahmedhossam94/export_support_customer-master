import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/BlocResources/login_bloc.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Screens/SignIn/child_widgets/signIn/sign_in_button.dart';
import 'package:export_support_customer/Screens/SignIn/child_widgets/signIn/sign_in_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInForm extends StatefulWidget {
  SignInForm({Key? key, required this.onSignIn, required this.onRegister})
      : super(key: key);

  final Function() onSignIn;
  final Function() onRegister;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String? _signInButtonTitle;
  String? _phoneCode;
  bool _isNew = false;
  LoginBloc? _loginBloc;
  AppLocalizations? _localizations;

  @override
  void initState() {
    _signInButtonTitle = "ENTER";
    _phoneCode = "+966";
    _isNew = false;
    super.initState();
  }

  bool _isValidPhone() {
    String phone = phoneController.text;
    if (phone.isEmpty) {
      Alert().warning(
          context: context,
          message:
              _localizations!.translate(LocalizedKey.noPhoneEnterAlertMessage),
          onPressed: () {
            Common.instance.dismiss(context);
          });
      return false;
    } else if (phone.length != 9) {
      Alert().warning(
          context: context,
          message: _localizations!
              .translate(LocalizedKey.notCorrectPhoneNumberAlertMessage),
          onPressed: () {
            Common.instance.dismiss(context);
          });
      return false;
    }

    return true;
  }

  bool _isValidName() {
    String name = nameController.text;
    if (name.isEmpty) {
      Alert().warning(
          context: context,
          message:
              _localizations!.translate(LocalizedKey.noNameEnterAlertMessage),
          onPressed: () {
            Common.instance.dismiss(context);
          });
      return false;
    }
    return true;
  }

  _handleSign() async {
    String phone;
    try {
      phone = "$_phoneCode${phoneController.text}";
      _loginBloc?.phoneForDisplay = phone;
      if (_isValidPhone()) {
        Common.instance.loading(context);

        bool isUserExist = await _loginBloc!.isUserExist();

        if (isUserExist) {
          widget.onSignIn();
        } else {
          setState(() {
            _isNew = true;
            _signInButtonTitle =
                _localizations?.translate(LocalizedKey.signUpButtonTitle);
          });
          Common.instance.dismiss(context);
        }
      }
    } on PlatformException catch (error) {
      Alert().requestFailwithMessage(
          context: context, message: error.message ?? '');
    }
  }

  _handleRegistration() {
    try {
      Common.instance.loading(context);
      if (_isValidPhone() && _isValidName()) {
        widget.onRegister();
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = BaseProvider.of<LoginBloc>(context);
    _localizations = AppLocalizations.of(context);

    _signInButtonTitle = _isNew
        ? _localizations?.translate(LocalizedKey.signUpButtonTitle)
        : _localizations?.translate(LocalizedKey.signInButtonTitle);

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Column(
              children: <Widget>[
                SignInPhoneTextField(
                  controller: phoneController,
                  isEnabled: !(_isNew),
                ),
                Container(
                  height: 16,
                ),
                _isNew
                    ? Column(
                        children: <Widget>[
                          SignInNameTextField(
                            controller: nameController,
                          ),
                          Container(
                            height: 16,
                          ),
                        ],
                      )
                    : Container(),
                SignInButton(
                  title: _signInButtonTitle ?? '',
                  onPressed: () {
                    (_isNew) ? _handleRegistration() : _handleSign();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
