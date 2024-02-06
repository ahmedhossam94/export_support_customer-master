import 'dart:io';

import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Alert {
  // ------------------------------------------------------ //
  // -------------- Alert Helper methods ------------------ //
  Widget _alertDialog(String title, String message, List<Widget> actions) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
          title: Text(title), content: Text(message), actions: actions);
    } else {
      return AlertDialog(
          title: Text(title), content: Text(message), actions: actions);
    }
  }

  Widget alertAction(String actionName, VoidCallback? onPressed) {
    if (Platform.isIOS) {
      return CupertinoDialogAction(
        child: Text(actionName),
        onPressed: onPressed,
      );
    } else {
      return ElevatedButton(
        child: Text(actionName),
        onPressed: onPressed,
      );
    }
  }

  String _getServiceNotAvailableAlertMessage(
      String id, AppLocalizations localizations) {
    switch (id) {
      case ServiceCatagoryID.airConditioner:
        return localizations.translate(LocalizedKey.acComingSoonAlertMessage);
      case ServiceCatagoryID.electric:
        return localizations
            .translate(LocalizedKey.electricComingSoonAlertMessage);
      case ServiceCatagoryID.plumbing:
        return localizations
            .translate(LocalizedKey.plumbingComingSoonAlertMessage);
      case ServiceCatagoryID.installing:
        return localizations
            .translate(LocalizedKey.installationComingSoonAlertMessage);
      case ServiceCatagoryID.cleaning:
        return localizations
            .translate(LocalizedKey.cleaningComingSoonAlertMessage);
      case ServiceCatagoryID.homeApplainces:
        return localizations
            .translate(LocalizedKey.homeApplaincesComingSoonAlertMessage);
      case ServiceCatagoryID.paint:
        return localizations
            .translate(LocalizedKey.paintComingSoonAlertMessage);
      case ServiceCatagoryID.securityCamera:
        return localizations
            .translate(LocalizedKey.securityCameraComingSoonAlertMessage);
      case ServiceCatagoryID.floors:
        return localizations
            .translate(LocalizedKey.floorComingSoonAlertMessage);
      case ServiceCatagoryID.elevator:
        return localizations
            .translate(LocalizedKey.elevatorComingSoonAlertMessage);
      case ServiceCatagoryID.onlineShop:
        return localizations
            .translate(LocalizedKey.onlineShopComingSoonAlertMessage);
      default:
        return localizations
            .translate(LocalizedKey.serviceComingSoonAlertMessage);
    }
  }
  // -------------- Alert Helper methods ------------------ //
  // ------------------------------------------------------ //

  void common(
      {required BuildContext context,
      required String title,
      required String message,
      required List<Widget> actions}) {
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _alertDialog(title, message, actions);
        });
  }

  void warning(
      {required BuildContext context,
      String? title,
      required String message,
      required VoidCallback onPressed}) {
    AppLocalizations localizations = AppLocalizations.of(context);
    Widget dimissAction = alertAction(
        localizations.translate(LocalizedKey.okayButtonTitle), onPressed);

    if (title == null) {
      title = localizations.translate(LocalizedKey.warningAlertTitle);
    }

    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _alertDialog(title ?? '', message, [dimissAction]);
        });
  }

  void error(
      {required BuildContext context,
      required String message,
      required VoidCallback onPressed}) {
    AppLocalizations localizations = AppLocalizations.of(context);
    String _title = localizations.translate(LocalizedKey.errorAlertTitle);
    Widget dimissAction = alertAction(
        localizations.translate(LocalizedKey.okayButtonTitle), onPressed);

    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _alertDialog(_title, message, [dimissAction]);
        });
  }

  void success(
      {required BuildContext context,
      required String message,
      required VoidCallback onPressed}) {
    AppLocalizations localizations = AppLocalizations.of(context);
    String _title = localizations.translate(LocalizedKey.successAlertTitle);
    Widget dimissAction = alertAction(
        localizations.translate(LocalizedKey.okayButtonTitle), onPressed);

    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _alertDialog(_title, message, [dimissAction]);
        });
  }

  void requestFail({required BuildContext context}) {
    AppLocalizations localizations = AppLocalizations.of(context);
    String _title = localizations.translate(LocalizedKey.errorAlertTitle);
    String _message =
        localizations.translate(LocalizedKey.requestFailAlertMessage);
    Widget dimissAction =
        alertAction(localizations.translate(LocalizedKey.okayButtonTitle), () {
      Common.instance.dismiss(context);
    });

    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _alertDialog(_title, _message, [dimissAction]);
        });
  }

  void requestFailwithMessage(
      {required BuildContext context, required String message}) {
    AppLocalizations localizations = AppLocalizations.of(context);
    String _title = localizations.translate(LocalizedKey.errorAlertTitle);
    Widget dimissAction =
        alertAction(localizations.translate(LocalizedKey.okayButtonTitle), () {
      Common.instance.dismiss(context);
    });

    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _alertDialog(_title, message, [dimissAction]);
        });
  }

  void serviceNotAvailable(
      {required BuildContext context,
      required String serviceCategoryID,
      required String serviceCategoryNameAr,
      required String serviceCategoryNameEn}) {
    AppLocalizations localizations = AppLocalizations.of(context);

    String comingSoon =
        localizations.translate(LocalizedKey.comingSoonAlertTitle);
    String serviceComingSoon =
        localizations.translate(LocalizedKey.serviceComingSoonAlertTitle);
    String _titleAr = "$comingSoon $serviceComingSoon $serviceCategoryNameAr";
    String _titleEn = "$serviceCategoryNameEn $serviceComingSoon $comingSoon";

    String _title = localizations.isArabic() ? _titleAr : _titleEn;
    String _message =
        _getServiceNotAvailableAlertMessage(serviceCategoryID, localizations);
    Widget dimissAction =
        alertAction(localizations.translate(LocalizedKey.okayButtonTitle), () {
      Navigator.of(context).pop();
    });

    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _alertDialog(_title, _message, [dimissAction]);
        });
  }

  void signOut(
      {required BuildContext context, required VoidCallback onSignOut}) {
    AppLocalizations localizations = AppLocalizations.of(context);
    String _title = localizations.translate(LocalizedKey.signOutAlertTitle);
    String _message = localizations.translate(LocalizedKey.signOutAlertMessage);
    Widget okAction =
        alertAction(localizations.translate(LocalizedKey.yesTitle), onSignOut);
    Widget dismissAction =
        alertAction(localizations.translate(LocalizedKey.noTitle), () {
      Common.instance.dismiss(context);
    });

    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _alertDialog(_title, _message, [okAction, dismissAction]);
        });
  }

  void conformation(
      {required BuildContext context,
      required String title,
      required String message,
      required VoidCallback okActionPressed,
      bool isLoading = false}) {
    AppLocalizations localizations = AppLocalizations.of(context);
    Widget okAction = alertAction(
        localizations.translate(LocalizedKey.yesTitle), okActionPressed);
    Widget dismissAction =
        alertAction(localizations.translate(LocalizedKey.noTitle), () {
      if (isLoading) {
        Common.instance.dismiss(context);
      }
      Common.instance.dismiss(context);
    });

    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _alertDialog(title, message, [okAction, dismissAction]);
        });
  }

  void warningWithOption(
      {required BuildContext context,
      required String title,
      required String message,
      required String optionTitle,
      required VoidCallback onOptionActionPressed}) {
    AppLocalizations localizations = AppLocalizations.of(context);
    Widget optionAction = alertAction(optionTitle, onOptionActionPressed);
    Widget dismissAction = alertAction(
        localizations.translate(LocalizedKey.cancelButtonTitle), () {
      Common.instance.dismiss(context);
    });

    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _alertDialog(title, message, [optionAction, dismissAction]);
        });
  }
}
