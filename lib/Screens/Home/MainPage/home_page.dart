import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/Screens/Home/MainPage/child_widgets/home_header.dart';
import 'package:export_support_customer/Screens/Home/MainPage/child_widgets/home_body.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String route = "/HomePage";

  HomePage({Key? key, this.isInNavigationStack = false}) : super(key: key);

  final bool isInNavigationStack;

  Widget _onHome() {
    return SafeArea(child: HomePageContent());
  }

  Widget _onNewService() {
    return ImageBackgroundContainer(
      imageName: ImageName.backgroundMain,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(child: HomePageContent()),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isInNavigationStack ? _onNewService() : _onHome();
  }
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HomeHeader(),
        Expanded(
          child: HomeBody(),
        )
      ],
    );
  }
}
