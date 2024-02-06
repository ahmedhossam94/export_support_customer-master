import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:flutter/material.dart';

class SignInHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screen.screenWidth * 0.4,
      child: Center(
        child: SignInAppLogo(),
      ),
    );
  }
}

class SignInAppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(ImageName.logoIconWithText),
      height: Screen.screenWidth * 0.2,
    );
  }
}

class SignInAppNameTitle extends StatelessWidget {
  SignInAppNameTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, color: Colors.white),
    );
  }
}
