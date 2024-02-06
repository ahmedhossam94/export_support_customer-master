import 'dart:io';
import 'dart:math';

import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/main_service_type.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Common {
  static final instance = Common();

  loading(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }

  String getServiceCategoryIconName(id, {bool isMainServicePage = false}) {
    switch (id) {
      case ServiceCatagoryID.airConditioner:
        {
          if (isMainServicePage) {
            return ImageName.ac_all;
          }
          return ImageName.airConditioner;
        }
      case ServiceCatagoryID.electric:
        return ImageName.electric;
      case ServiceCatagoryID.plumbing:
        return ImageName.plumbing;
      case ServiceCatagoryID.installing:
        return ImageName.installing;
      case ServiceCatagoryID.cleaning:
        return ImageName.cleaning;
      case ServiceCatagoryID.homeApplainces:
        return ImageName.homeApplainces;
      case ServiceCatagoryID.paint:
        return ImageName.paint;
      case ServiceCatagoryID.securityCamera:
        return ImageName.securityCamera;
      case ServiceCatagoryID.floors:
        return ImageName.floors;
      case ServiceCatagoryID.elevator:
        return ImageName.elevator;
      case ServiceCatagoryID.onlineShop:
        return ImageName.cart;
      default:
        return "";
    }
  }

  String getDealHomePageIconName() {
    return ImageName.deals;
  }

  String getACTypeImage(String serviceType) {
    switch (serviceType) {
      case ACType.splite:
        return ImageName.split_ac;
      case ACType.cassette:
        return ImageName.window_ac;
      case ACType.package:
        return ImageName.tower_ac;
      case ACType.centralPackage:
        return ImageName.central_ac;
      case ACType.centralConcealed:
        return ImageName.concealed_ac;
      default:
        return "";
    }
  }

  notavigateTo(
      {required Widget page,
      required String pageName,
      required BuildContext context}) {
    Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: pageName), builder: (context) => page));
  }

  showPhotoModal(
      {required BuildContext context,
      required Function onCameraTap,
      required Function onPhotoTap}) {
    AppLocalizations localizations = AppLocalizations.of(context);

    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (_) => CupertinoActionSheet(
                actions: <Widget>[
                  _mediaCupertinoAction(context,
                      localizations.translate(LocalizedKey.cameraIOSTitle),
                      action: onCameraTap),
                  _mediaCupertinoAction(context,
                      localizations.translate(LocalizedKey.galleryIOSTitle),
                      action: onPhotoTap),
                ],
                cancelButton: _mediaCupertinoAction(context,
                    localizations.translate(LocalizedKey.cancelButtonTitle),
                    isDefaultAction: true, action: () {}),
              ));
    } else {
      showModalBottomSheet(
          context: context,
          builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _medialTile(
                      context,
                      localizations.translate(LocalizedKey.cameraAndroidTitle),
                      Icons.camera_alt,
                      onCameraTap),
                  _medialTile(
                      context,
                      localizations.translate(LocalizedKey.galleryAndroidTitle),
                      Icons.photo_album,
                      onPhotoTap),
                ],
              ));
    }
  }

  ListTile _medialTile(
      BuildContext context, String name, IconData icon, Function action) {
    return ListTile(
        leading: Icon(icon),
        title: Text(name),
        onTap: () {
          Navigator.of(context).pop();
          action();
        });
  }

  CupertinoActionSheetAction _mediaCupertinoAction(
      BuildContext context, String name,
      {required Function action, bool isDefaultAction = false}) {
    return CupertinoActionSheetAction(
        child: Text(name),
        isDefaultAction: isDefaultAction,
        onPressed: () {
          Common.instance.dismiss(context);
          action();
        });
  }

  bool isKeyboardShowing(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0.0;
  }

  removeFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  double round({required double value, required int places}) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  showContactTechViaWhatsApp(
      {required BuildContext context,
      required String title,
      required String message,
      required VoidCallback onPressed}) {
    AppLocalizations localizations = AppLocalizations.of(context);
    Widget openWhatsappAction = modalAction(
        localizations.translate(LocalizedKey.openWhatsappButtonTitle),
        onPressed);
    Widget dimissAction = modalAction(
        localizations.translate(LocalizedKey.cancelButtonTitle), () {
      Common.instance.dismiss(context);
    });

    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return _modalDialog(
              title, message, [openWhatsappAction, dimissAction]);
        });
  }

  Widget _modalDialog(String title, String message, List<Widget> actions) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
          title: Text(title), content: Text(message), actions: actions);
    } else {
      return AlertDialog(
          title: Text(title), content: Text(message), actions: actions);
    }
  }

  Widget modalAction(String actionName, VoidCallback? onPressed) {
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
}
