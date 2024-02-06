import 'dart:io';

import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/loader.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatelessWidget {
  LaunchPage({Key? key, this.isLoading = true}) : super(key: key);

  final GlobalKey _scaffold = GlobalKey();
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    Screen.instance.init(context);
    double bottonInset = Platform.isIOS ? 24.0 : 16;

    return ImageBackgroundContainer(
        imageName: ImageName.backgroundMain,
        child: Scaffold(
          key: _scaffold,
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            actions: [],
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                  top: 16, left: 16, right: 16, bottom: bottonInset),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Center(
                    child: Image(
                      image: AssetImage(ImageName.logoIconWithText),
                      width: Screen.screenWidth * 0.5,
                    ),
                  )),
                  LaunchPageLoader(
                    isLoading: isLoading,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "from",
                        style: TextStyle(fontSize: Screen.fontSize(size: 16)),
                      ),
                      Container(
                        height: 4,
                      ),
                      Text(
                        "EXPERTS SUPPORT",
                        style: TextStyle(fontSize: Screen.fontSize(size: 24)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class LaunchPageLoader extends StatelessWidget {
  LaunchPageLoader({Key? key, this.isLoading = false}) : super(key: key);

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Container(
              padding: EdgeInsets.only(bottom: 24),
              alignment: FractionalOffset.bottomCenter,
              child: Loader(
                color: Colors.grey,
              ),
            )
          : Container(),
    );
  }
}
