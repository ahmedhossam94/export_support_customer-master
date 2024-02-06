import 'dart:ui';

import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/general_details.dart';
import 'package:export_support_customer/SharedWisget/social_media_image.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  static const String route = "/ContactUsPage";

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ContactUsBody());
  }
}

class ContactUsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AboutUs? aboutUs = BaseProvider.of<AppBloc>(context).generalDetails.aboutUs;
    AppLocalizations? localizations = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Text(
            localizations!.isArabic()
                ? aboutUs?.headerAr ?? ''
                : aboutUs?.headerEn ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
          Container(
            height: 16,
          ),
          Text(
            localizations.isArabic()
                ? aboutUs?.aboutUsAr ?? ''
                : aboutUs?.aboutUsEn ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          Container(
            height: 32,
          ),
          Text(
            localizations.translate(LocalizedKey.followUsViaTitle) ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialMediaImage(ImageName.instagram),
                SocialMediaImage(ImageName.twitter),
                SocialMediaImage(ImageName.facebook),
              ],
            ),
          )
        ],
      ),
    );
  }
}
