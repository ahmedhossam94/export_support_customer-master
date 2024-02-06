import 'dart:async';

import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/BlocResources/login_bloc.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/delegates.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/enums.dart';
import 'package:export_support_customer/Screens/SignIn/child_widgets/signIn/sign_in_main.dart';
import 'package:export_support_customer/Screens/SignIn/child_widgets/verifyCode/verify_code_main.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatelessWidget {
  static const String route = "/SignInPage";

  SignInPage({Key? key, this.isPerformSignInInTheMiddle = false})
      : super(key: key);

  final bool isPerformSignInInTheMiddle;

  @override
  Widget build(BuildContext context) {
    return BlocBaseProvider<LoginBloc>(
      builder: (context, loginBloc) => loginBloc ?? LoginBloc(),
      onDispose: (context, loginBloc) => loginBloc.dispose(),
      child: SignInPageContent(
        isPerformSignInInTheMiddle: isPerformSignInInTheMiddle,
      ),
    );
  }
}

class SignInPageContent extends StatefulWidget {
  static const String route = "/SignInPage";

  SignInPageContent({Key? key, required this.isPerformSignInInTheMiddle})
      : super(key: key);

  final bool isPerformSignInInTheMiddle;

  @override
  _SignInPageContentState createState() => _SignInPageContentState();
}

class _SignInPageContentState extends State<SignInPageContent>
    implements CodeSendDelegate, CodeVerifyDelegate {
  SignInPageStatus? currentStatus;
  LoginBloc? _loginBloc;
  AppBloc? _appBloc;
  AppLocalizations? _localizations;

  bool? isUserExist;
  int _resendCountdown = 0;
  Timer? _timer;

  @override
  void initState() {
    currentStatus = SignInPageStatus.signIn;
    isUserExist = false;
    _resendCountdown = 60;

    super.initState();
  }

  _startTime() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      setState(() {
        if (_resendCountdown < 1) {
          //_resendCountdown = 60;
          timer.cancel();
        } else {
          _resendCountdown = _resendCountdown - 1;
        }
      });
    });
  }

  Future<bool> _handleBackButton() async {
    if (currentStatus == SignInPageStatus.signIn) {
      return true;
    }
    _goBackToSignIn();
    return false;
  }

  _goToVerifyCodePage() {
    setState(() {
      currentStatus = SignInPageStatus.verifyCode;
    });
  }

  _goBackToSignIn() {
    _timer?.cancel();
    setState(() {
      currentStatus = SignInPageStatus.signIn;
    });
  }

  _onSignIn() async {
    isUserExist = true;
    await _loginBloc?.sendVerificationCode(this);
    //_goToVerifyCodePage(true);
  }

  _onRegister() async {
    isUserExist = false;
    await _loginBloc?.sendVerificationCode(this);
    //_goToVerifyCodePage(false);
  }

  _onVerifyCode() async {
    Common.instance.loading(context);
    await _loginBloc?.signIn(
        delegate: this,
        isUserExist: isUserExist ?? false,
        lang: _localizations!.locale!.languageCode);
  }

  _onResendVerifyCode() async {
    Common.instance.loading(context);
    await _loginBloc?.sendVerificationCode(this);
    setState(() {
      _resendCountdown = 60;
    });
    Common.instance.dismiss(context);
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc = BaseProvider.of<LoginBloc>(context);
    _appBloc = BaseProvider.of<AppBloc>(context);
    _localizations = AppLocalizations.of(context);

    return ImageBackgroundContainer(
      imageName: ImageName.backgroundMain,
      child: WillPopScope(
        onWillPop: _handleBackButton,
        child: Scaffold(
            appBar: CustomAppBar(),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: currentStatus == SignInPageStatus.signIn
                  ? SignIn(onSignIn: _onSignIn, onRegister: _onRegister)
                  : VerifyCode(
                      onVerifyCode: _onVerifyCode,
                      onResendVerifyCode: _onResendVerifyCode,
                      resendCountdown: _resendCountdown,
                    ),
            )),
      ),
    );
  }

  @override
  void onAutoRetrieveTimeout(String verId) =>
      _loginBloc?.verificationID = verId;

  @override
  void onAutoRetrieveVerify(AuthCredential authCredential) async {
    await _loginBloc?.signIn(
        autoRetrieveAuthCredential: authCredential,
        delegate: this,
        isUserExist: isUserExist ?? false,
        lang: _localizations!.locale!.languageCode);
  }

  @override
  void onCodeSendError(String error) {
    Common.instance.dismiss(context);
    print("error: ${error.toString()}");
    Alert().warning(
        context: context,
        message: _localizations!
            .translate(LocalizedKey.sendVerifyCodeErrorAlertMessage),
        onPressed: () => Common.instance.dismiss(context));
  }

  @override
  void onCodeSendSuccess(String verId, int forceCodeResend) {
    Common.instance.dismiss(context);
    _startTime();
    _loginBloc?.verificationID = verId;
    _loginBloc?.forceCodeResendChange(forceCodeResend);
    _goToVerifyCodePage();
  }

  @override
  void onCodeVerifyError(String error) {
    Common.instance.dismiss(context);
    Alert().warning(
        context: context,
        message:
            _localizations!.translate(LocalizedKey.verifyCodeErrorAlertMessage),
        onPressed: () => Common.instance.dismiss(context));
  }

  @override
  void onCodeVerifySuccess(User user) async {
    try {
      if (_timer != null) {
        _timer?.cancel();
      }

      _appBloc?.setUser.add(_loginBloc!.userInfo!);

      await _appBloc!.updateUserFCMTokenOnSignIn();

      Common.instance.dismiss(context);
      if (widget.isPerformSignInInTheMiddle) {
        Navigator.of(context).pop(user.uid);
      } else {
        Common.instance.dismiss(context);
      }
    } on PlatformException catch (_) {
      Common.instance.dismiss(context);
      if (widget.isPerformSignInInTheMiddle) {
        Navigator.of(context).pop();
      } else {
        Common.instance.dismiss(context);
      }
    }
  }
}
