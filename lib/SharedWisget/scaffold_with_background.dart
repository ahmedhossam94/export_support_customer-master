import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:flutter/material.dart';

class ImageBackgroundContainer extends StatelessWidget {
  ImageBackgroundContainer({Key? key, String? imageName, required this.child})
      : imageName = imageName ?? ImageName.backgroundSreens,
        super(key: key);

  final String imageName;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(imageName), fit: BoxFit.cover)),
        child: child);
  }
}
