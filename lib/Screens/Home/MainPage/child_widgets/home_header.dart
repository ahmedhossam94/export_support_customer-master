import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Image(
            image: AssetImage(ImageName.logoIcon),
            height: Screen.screenWidth * 0.19,
          ),
        ),
        Container(
          height: 16,
        ),
      ],
    );
  }
}
