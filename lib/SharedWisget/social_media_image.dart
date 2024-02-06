import 'dart:io';

import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Models/general_details.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaImage extends StatelessWidget {
  final String imageName;
  SocialMediaImage(this.imageName);

  _onImageTapped(BuildContext context, AboutUs aboutUs) async {
    String _url;
    String? _webUrl;

    String phone = "";
    if (Platform.isIOS) {
      phone = aboutUs.phone.replaceAll('+', '');
    } else {
      phone = aboutUs.phone;
    }

    switch (imageName) {
      case ImageName.phone:
        _url = "tel://${aboutUs.phone}";
        break;
      case ImageName.whatsapp:
        _url = "whatsapp://send?phone=$phone";
        break;
      case ImageName.instagram:
        _url = "instagram://user?username=${aboutUs.instagram}";
        _webUrl = "https://www.instagram.com/${aboutUs.instagram}";
        break;
      case ImageName.twitter:
        _url = "twitter://user?screen_name=${aboutUs.twitter}";
        _webUrl = "https://twitter.com/${aboutUs.twitter}";
        break;
      case ImageName.facebook:
        _url = "fb://profile/${aboutUs.facebook}";
        _webUrl = "https://www.facebook.com/${aboutUs.facebook}";
        break;
      default:
        _url = "Not found";
    }

    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      if (_webUrl != null && await canLaunch(_webUrl)) {
        await launch(_webUrl);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AboutUs aboutUs = BaseProvider.of<AppBloc>(context).generalDetails.aboutUs;

    return GestureDetector(
      onTap: () {
        _onImageTapped(context, aboutUs);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Image(
          image: AssetImage(imageName),
          height: Screen.screenWidth * 0.1,
          width: Screen.screenWidth * 0.1,
        ),
      ),
    );
  }
}
