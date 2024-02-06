import 'dart:io';

import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_language.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/enums.dart';
import 'package:export_support_customer/Models/local_code.dart';
import 'package:export_support_customer/Models/menu.dart';
import 'package:export_support_customer/Models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({Key? key, required this.onMenuItemTap});
  final Function(MenuRouteType) onMenuItemTap;

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BaseProvider.of<AppBloc>(context);
    return Drawer(
      child: Container(
        color: AppColor.darkGrayDouble,
        child: SafeArea(
          bottom: false,
          child: Container(
            child: StreamBuilder<UserModel>(
                stream: appBloc.user,
                builder: (context, snapshot) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MenuListHeader(
                        isUserExist: snapshot.hasData,
                        user: snapshot.data!,
                      ),
                      Expanded(
                          child: MenuListBody(
                        isUserExist: snapshot.hasData,
                        onMenuItemTap: onMenuItemTap,
                      ))
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class MenuListHeader extends StatelessWidget {
  MenuListHeader({Key? key, required this.isUserExist, required this.user})
      : super(key: key);

  final UserModel user;
  final bool isUserExist;

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);
    final String? name = isUserExist && user != UserModel()
        ? user.name
        : appLocalizations.translate(LocalizedKey.guestTitle);
    final String? phone = (isUserExist) ? user.phone : '';
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Image(
              image: AssetImage(ImageName.logoIconWithText),
              height: Screen.screenWidth * 0.15,
            )),
            Container(
              height: 24,
            ),
            Text(
              "${appLocalizations.translate(LocalizedKey.welcomeTitle)} $name",
              style: TextStyle(fontSize: 18, color: AppColor.dartOrange),
            ),
            phone != null
                ? Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      phone,
                      style:
                          TextStyle(fontSize: 16, color: AppColor.dartOrange),
                    ),
                  )
                : Container(),
          ]),
    );
  }
}

class MenuListBody extends StatefulWidget {
  MenuListBody(
      {Key? key, required this.isUserExist, required this.onMenuItemTap})
      : super(key: key);

  final bool isUserExist;
  final Function(MenuRouteType) onMenuItemTap;

  @override
  _MenuListBodyState createState() => _MenuListBodyState();
}

class _MenuListBodyState extends State<MenuListBody> {
  bool isUserExist = false;
  AppBloc? _appBloc;
  String link = '';
  AppLanguage? _appLanguage;
  AppLocalizations? _appLocalizations;

  void initState() {
    isUserExist = widget.isUserExist;
    super.initState();
  }

  List<Menu> _getMenuList() {
    if (widget.isUserExist) {
      return [
        Menu(
            name: _appLocalizations!.translate(LocalizedKey.homeTitle),
            type: MenuRouteType.home),
        Menu(
            name: _appLocalizations!.translate(LocalizedKey.myOrderTitle),
            type: MenuRouteType.orderHistory),
        Menu(
            name: _appLocalizations!.translate(LocalizedKey.supportTitle),
            type: MenuRouteType.support),
        Menu(
            name: _appLocalizations!.translate(LocalizedKey.aboutUsTitle),
            type: MenuRouteType.aboutUs),
        Menu(
            name: _appLocalizations!
                .translate(LocalizedKey.termsAndConditionsTitle),
            type: MenuRouteType.termsAndConditions),
        Menu(
            name: _appLocalizations!.translate(LocalizedKey.shareAppTitle),
            type: MenuRouteType.shareApp),
        Menu(
            name: _appLocalizations!.translate(LocalizedKey.signOutTitle),
            type: MenuRouteType.signOut),
        Menu(
            name: _appLocalizations!.translate(LocalizedKey.languageTitle),
            type: MenuRouteType.langauge),
      ];
    }

    return [
      Menu(
          name: _appLocalizations!.translate(LocalizedKey.homeTitle),
          type: MenuRouteType.home),
      Menu(
          name: _appLocalizations!.translate(LocalizedKey.supportTitle),
          type: MenuRouteType.support),
      Menu(
          name: _appLocalizations!.translate(LocalizedKey.aboutUsTitle),
          type: MenuRouteType.aboutUs),
      Menu(
          name: _appLocalizations!
              .translate(LocalizedKey.termsAndConditionsTitle),
          type: MenuRouteType.termsAndConditions),
      Menu(
          name: _appLocalizations!.translate(LocalizedKey.shareAppTitle),
          type: MenuRouteType.shareApp),
      Menu(
          name: _appLocalizations!.translate(LocalizedKey.signInTitle),
          type: MenuRouteType.signIn),
      Menu(
          name: _appLocalizations!.translate(LocalizedKey.languageTitle),
          type: MenuRouteType.langauge),
    ];
  }

  _onMenuItemTap(Menu menu) {
    if (menu.type == MenuRouteType.orderHistory && !widget.isUserExist) {
      return;
    }

    switch (menu.type) {
      case MenuRouteType.shareApp:
        _shareApp();
        break;
      case MenuRouteType.signOut:
        _signOutConformation();
        break;
      case MenuRouteType.langauge:
        _changeLang();
        break;
      default:
        Common.instance.dismiss(context);
        widget.onMenuItemTap(menu.type);
        break;
    }
  }

  _shareApp() {
    String formattedLink = link.contains("http://") || link.contains("https://")
        ? link
        : "https://" + link;
    Share.share(formattedLink, subject: "Experts Support App");
  }

  _signOutConformation() {
    Alert().signOut(context: context, onSignOut: () => _signOut());
  }

  _signOut() async {
    try {
      Common.instance.dismiss(context);
      Common.instance.loading(context);

      await _appBloc!.updateUserFCMTokenOnSignOut();

      _appBloc?.setUser.add(UserModel());
      await _appBloc!.signOut();

      Common.instance.dismiss(context);
    } on PlatformException catch (error) {
      Alert().requestFailwithMessage(
          context: context, message: error.message ?? '');
    }
  }

  _changeLang() async {
    try {
      Common.instance.loading(context);

      Locale newLocaleLang = _appLanguage?.appLocal == LocaleCode.englishLocale
          ? LocaleCode.arabicLocale
          : LocaleCode.englishLocale;
      _appLanguage?.changeLanguage(newLocaleLang);

      await _appBloc!.updateUserlangOnChangeLang(newLocaleLang.languageCode);

      Common.instance.dismiss(context);
    } on PlatformException catch (error) {
      Alert().requestFailwithMessage(
          context: context, message: error.message ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    _appBloc = BaseProvider.of<AppBloc>(context);
    _appLanguage = Provider.of<AppLanguage>(context);
    _appLocalizations = AppLocalizations.of(context);

    link = Platform.isIOS
        ? _appBloc!.generalDetails.shared.link
        : _appBloc!.generalDetails.shared.linkAndroid;

    final List<Menu> menuList = _getMenuList();
    return Container(
      color: AppColor.darkGray,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
            itemCount: menuList.length,
            separatorBuilder: (_, index) {
              return Divider(
                color: AppColor.darkGrayDouble,
                height: 2,
              );
            },
            itemBuilder: (_, index) {
              final Menu menu = menuList[index];
              return ListTile(
                title: Text(menu.name,
                    style: TextStyle(fontSize: 18, color: AppColor.dartOrange)),
                onTap: () {
                  _onMenuItemTap(menu);
                },
              );
            }),
      ),
    );
  }
}
