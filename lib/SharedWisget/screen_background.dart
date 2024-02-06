import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:flutter/material.dart';

class ScreenBackground extends StatelessWidget {
  final String imageName;
  ScreenBackground({Key? key, String? imageName})
      : imageName = imageName ?? ImageName.backgroundSreens,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(imageName), fit: BoxFit.cover)),
    );
  }
}
