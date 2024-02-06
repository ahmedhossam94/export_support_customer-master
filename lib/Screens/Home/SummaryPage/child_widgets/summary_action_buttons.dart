import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/BlocResources/submitted_order_bloc.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:export_support_customer/Screens/MenuNavigation/nav_screen.dart';
import 'package:export_support_customer/Screens/SignIn/sign_in_page.dart';
import 'package:export_support_customer/Screens/TermsAndConditions/terms_and_conditions_page.dart';
import 'package:export_support_customer/SharedWisget/common_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SummaryPageContentButtons extends StatefulWidget {
  @override
  _SummaryPageContentButtonsState createState() =>
      _SummaryPageContentButtonsState();
}

class _SummaryPageContentButtonsState extends State<SummaryPageContentButtons> {
  AppBloc? _appBloc;
  AppLocalizations? _localizations;
  SubmittedOrderBloc? _submittedOrderBloc;
  String? _userID;

  @override
  initState() {
    _submittedOrderBloc = SubmittedOrderBloc();
    super.initState();
  }

  _onTermsAndConditionLinkTapped() {
    Common.instance.notavigateTo(
        page: TermsAndConditionsPage(
          isInNavigationStack: true,
        ),
        pageName: "TermsAndConditionsPage",
        context: context);
  }

  _onSubmitOrderButtonTapped() async {
    bool isPaymentMethodEnable =
        _appBloc!.generalDetails.submitOrder.isCashEnabled ||
            _appBloc!.generalDetails.submitOrder.isPOSEnabled;
    if (isPaymentMethodEnable && _appBloc == null) {
      Alert().warning(
          context: context,
          message: _localizations!
              .translate(LocalizedKey.noPaymentMethodSelectAlertMessage),
          onPressed: () {
            Common.instance.dismiss(context);
          });
    } else {
      Common.instance.loading(context);
      _userID = await _submittedOrderBloc!.isUserSignedIn();
      if (_userID != null) {
        _onSubmitOrder();
      } else {
        Common.instance.dismiss(context);
        Alert().warningWithOption(
            context: context,
            title: _localizations!.translate(LocalizedKey.signInTitle),
            message:
                _localizations!.translate(LocalizedKey.notSignInAlertMessage),
            optionTitle:
                _localizations!.translate(LocalizedKey.signInButtonTitle),
            onOptionActionPressed: _navigateToLogin);
      }
    }
  }

  _navigateToLogin() async {
    Common.instance.dismiss(context);

    final String result = await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => SignInPage(
                isPerformSignInInTheMiddle: true,
              )),
    );

    if (result != null) {
      _userID = result;
      Common.instance.loading(context);
      _onSubmitOrder();
    }
  }

  _onSubmitOrder() {
    Alert().conformation(
        context: context,
        title: _localizations!
            .translate(LocalizedKey.submitOrderConformationAlertMessage),
        message: _localizations!
            .translate(LocalizedKey.acknowledgeOfTermsBeforeSubmitAlertMeesage),
        isLoading: true,
        okActionPressed: () {
          _saveOrder();
          Common.instance.dismiss(context);
        });
  }

  _saveOrder() async {
    bool canSubmitOrder =
        true; //await _submittedOrderBloc.canSubmitOrder(userID: _userID, onError: _onSaveError);

    if (canSubmitOrder) {
      _submittedOrderBloc!.saveOrder(
          submittedOrder: _appBloc!.submittedOrder,
          userID: _userID ?? '',
          onSuccess: _onSaveSuccess,
          onError: _onSaveError);
    } else {
      // Common.instance.dismiss(context);
      // Alert().warning(
      //     context: context,
      //     message: _localizations
      //         .translate(LocalizedKey.submitMoreOrderErrorAlertMessge),
      //     onPressed: () {
      //       Common.instance.dismiss(context);
      //     });
    }
  }

  _onSaveSuccess() {
    Common.instance.dismiss(context);
    Alert().success(
        context: context,
        message: _localizations!
            .translate(LocalizedKey.succussSubmitOrderAlertMessage),
        onPressed: () {
          Common.instance.dismiss(context);
          _clearOrder();
        });
  }

  _onSaveError(String error) {
    Common.instance.dismiss(context);
    Alert().requestFailwithMessage(context: context, message: error);
  }

  _onCancelOrderButtonTapped() {
    Alert().conformation(
        context: context,
        title: _localizations!
            .translate(LocalizedKey.cancelOrderConformationAlertTitle),
        message: _localizations!
            .translate(LocalizedKey.cancelOrderConformationAlertMessage),
        okActionPressed: _clearOrder);
  }

  _clearOrder() {
    _appBloc?.isAddNewService = false;
    _appBloc?.submittedOrder = SubmittedOrder();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => NavScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    _appBloc = BaseProvider.of(context);
    _localizations = AppLocalizations.of(context);

    return Container(
      child: Column(
        children: <Widget>[
          TermsAndConditionText(
            onTap: _onTermsAndConditionLinkTapped,
          ),
          Container(
            height: 8,
          ),
          CommonButton(
              title: _localizations!
                  .translate(LocalizedKey.confromOrderButtonTitle),
              onPressed: _onSubmitOrderButtonTapped),
          Container(
            height: 8,
          ),
          CommonButton(
              title: _localizations!
                  .translate(LocalizedKey.cancelOrderButtonTitle),
              onPressed: _onCancelOrderButtonTapped)
        ],
      ),
    );
  }
}

class TermsAndConditionText extends StatelessWidget {
  TermsAndConditionText({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      child: RichText(
        text: TextSpan(
            text: localizations.translate(LocalizedKey.agreeTermsTitle) + ' ',
            style: TextStyle(
                color: Colors.black,
                fontSize: Screen.fontSize(size: 18),
                fontFamily: 'CoconNextArabic'),
            children: <TextSpan>[
              TextSpan(
                  text: localizations.translate(LocalizedKey.termsLinkTitle),
                  style: TextStyle(
                      color: Colors.green, fontSize: Screen.fontSize(size: 18)),
                  recognizer: TapGestureRecognizer()..onTap = onTap)
            ]),
      ),
    );
  }
}
