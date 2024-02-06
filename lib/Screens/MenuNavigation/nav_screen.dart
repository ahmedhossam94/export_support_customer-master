import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/Models/enums.dart';
import 'package:export_support_customer/Models/menu.dart';
import 'package:export_support_customer/Models/user.dart';
import 'package:export_support_customer/Screens/ContactUs/contact_us_page.dart';
import 'package:export_support_customer/Screens/Home/MainPage/home_page.dart';
import 'package:export_support_customer/Screens/Notification/notification_page.dart';
import 'package:export_support_customer/Screens/OrderHistory/MainPage/order_history_page.dart';
import 'package:export_support_customer/Screens/SignIn/sign_in_page.dart';
import 'package:export_support_customer/Screens/Support/support_page.dart';
import 'package:export_support_customer/Screens/TermsAndConditions/terms_and_conditions_page.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';

import 'menu_drawer.dart';

class NavScreen extends StatefulWidget {
  static const String route = "/NavScreen";

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  List<MenuContent> _contentList = [];
  int selectedContent = 0;
  MenuContent? _selectContent;

  @override
  void initState() {
    selectedContent = 0;
    _contentList = [
      MenuContent(type: MenuRouteType.home, widget: HomePage()),
      MenuContent(type: MenuRouteType.orderHistory, widget: OrderHistoryPage()),
      MenuContent(type: MenuRouteType.support, widget: SupportPage()),
      MenuContent(type: MenuRouteType.aboutUs, widget: ContactUsPage()),
      MenuContent(
          type: MenuRouteType.termsAndConditions,
          widget: TermsAndConditionsPage()),
      MenuContent(type: MenuRouteType.signIn, widget: SignInPage()),
    ];
    _selectContent = _contentList.first;

    super.initState();
  }

  CustomAppBar _getAppBar(MenuRouteType type, bool isUserExist) {
    if (type == MenuRouteType.home && isUserExist) {
      return CustomAppBar(actions: showNotificationPage(context));
    }
    return CustomAppBar();
  }

  List<Widget> showNotificationPage(BuildContext context) {
    return [
      ElevatedButton(
          child: Icon(
            Icons.notifications,
            size: 32,
          ),
          onPressed: () {
            Navigator.pushNamed(context, NotificationPage.route);
          })
    ];
  }

  _onMenuChangeScreen(MenuRouteType type) {
    List<MenuContent> selectedMenuContentList =
        _contentList.where((c) => c.type == type).toList();
    if (selectedMenuContentList != null && selectedMenuContentList.length > 0) {
      if (type == MenuRouteType.signIn) {
        setState(() {
          _selectContent = _contentList.first;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed(SignInPage.route);
        });
      } else {
        setState(() {
          _selectContent = selectedMenuContentList.first;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BaseProvider.of<AppBloc>(context);

    return ImageBackgroundContainer(
        imageName: _selectContent?.type == MenuRouteType.home
            ? ImageName.backgroundMain
            : null,
        child: StreamBuilder<UserModel>(
            stream: appBloc.user,
            builder: (context, snapshot) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: _getAppBar(_selectContent!.type, snapshot.hasData),
                drawer: MenuDrawer(
                  onMenuItemTap: _onMenuChangeScreen,
                ),
                body: _selectContent?.widget,
              );
            }));
  }
}
