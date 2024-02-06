import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/SharedWisget/social_media_image.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  static const String route = "/SupportPage";

  @override
  Widget build(BuildContext context) {

    return SafeArea(child: SupportPageBody());
  }
}

class SupportPageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            localizations.translate(LocalizedKey.supportTitle),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Screen.fontSize(size: 28)
            ),
          ),
          Container(height: 16,),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SocialMediaImage(ImageName.phone),
                    Text(localizations.translate(LocalizedKey.callTitle), style: TextStyle(fontSize: Screen.fontSize(size: 24)),)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SocialMediaImage(ImageName.whatsapp),
                    Text(localizations.translate(LocalizedKey.whatsappTitle), style: TextStyle(fontSize: Screen.fontSize(size: 24)),)
                  ],
                ),
              ],
            ),
          )
        ]
      )
    );
  }
}