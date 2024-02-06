import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/FirebaseResources/firebase_manager.dart';
import 'package:export_support_customer/FirebaseResources/notification.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/Localization/app_language.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Models/local_code.dart';
import 'package:export_support_customer/Screens/ContactUs/contact_us_page.dart';
import 'package:export_support_customer/Screens/Home/AppliedServices/applied_services.dart';
import 'package:export_support_customer/Screens/Home/MainPage/home_page.dart';
import 'package:export_support_customer/Screens/MenuNavigation/nav_screen.dart';
import 'package:export_support_customer/Screens/Notification/notification_page.dart';
import 'package:export_support_customer/Screens/Offers/offers_page.dart';
import 'package:export_support_customer/Screens/OrderHistory/MainPage/order_history_page.dart';
import 'package:export_support_customer/Screens/SignIn/sign_in_page.dart';
import 'package:export_support_customer/Screens/Support/support_page.dart';
import 'package:export_support_customer/Screens/TermsAndConditions/terms_and_conditions_page.dart';
import 'package:export_support_customer/launch_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class InitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBaseProvider<AppBloc>(
        builder: (context, appBloc) => appBloc,
        onDispose: (context, appBloc) => appBloc.dispose(),
        child: MyApp());
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseManager? _firebaseManager;
  AppLanguage? _appLanguage;
  AppBloc? _appBloc;
  bool? _isLoading;
  bool? _isError;

  @override
  void initState() {
    _firebaseManager = FirebaseManager();
    _appLanguage = AppLanguage();
    _appBloc = AppBloc();
    _isLoading = true;
    _isError = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => init());
    super.initState();
  }

  init() async {
    try {
      await _appLanguage?.fetchLocale();

      if (kDebugMode) {
        // await _firebaseManager.updateDatabaseTest();
        // await _firebaseManager.setServices();
      }

      QuerySnapshot serviceInfoQuerySnapshot =
          await _firebaseManager!.getServices();
      QuerySnapshot generalDetailsInfoQuerySnapshot =
          await _firebaseManager!.getGeneralDetails();

      _appBloc?.setServiceInfo(serviceInfoQuerySnapshot);
      _appBloc?.setGeneralDetails(generalDetailsInfoQuerySnapshot);
      await _appBloc?.updateUserInfoIfExist();

      FirebaseNotifications().setUpFirebase(_appBloc!);

      _stopLoading();
    } on PlatformException catch (e) {
      Alert()
          .requestFailwithMessage(context: context, message: e.message ?? '');
      _stopLoading(isError: true);
    }
  }

  _stopLoading({bool isError = false}) {
    setState(() {
      _isLoading = false;
      _isError = isError;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading ?? false) {
      return LaunchMaterialApp();
    }

    if (_isError ?? false) {
      return LaunchMaterialApp(
        isLoading: _isLoading ?? false,
      );
    }

    return InitMaterialApp(
      appLanguage: _appLanguage!,
      initAppBloc: _appBloc!,
    );
  }
}

class LaunchMaterialApp extends StatelessWidget {
  LaunchMaterialApp({Key? key, this.isLoading = true});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LaunchPage(
          isLoading: isLoading,
        ));
  }
}

class InitMaterialApp extends StatelessWidget {
  InitMaterialApp(
      {Key? key, required this.appLanguage, required this.initAppBloc})
      : super(key: key);

  final AppLanguage appLanguage;
  final AppBloc initAppBloc;

  Map<String, WidgetBuilder> _getRoute() {
    return {
      NavScreen.route: (BuildContext context) => NavScreen(),
      HomePage.route: (BuildContext context) => HomePage(),
      ContactUsPage.route: (BuildContext context) => ContactUsPage(),
      SignInPage.route: (BuildContext context) => SignInPage(),
      OrderHistoryPage.route: (BuildContext context) => OrderHistoryPage(),
      AppliedServices.route: (BuildContext context) => AppliedServices(),
      SupportPage.route: (BuildContext context) => SupportPage(),
      TermsAndConditionsPage.route: (BuildContext context) =>
          TermsAndConditionsPage(),
      NotificationPage.route: (BuildContext context) => NotificationPage(),
      OffersPage.route: (BuildContext context) => OffersPage(),
    };
  }

  ThemeData _getTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
      ),
      fontFamily: 'CoconNextArabic',
    );
  }

  Iterable<LocalizationsDelegate<dynamic>> _getLocalDelegate() {
    return [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }

  Locale? _onLocaleResolution(
      Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      debugPrint("*language locale is null!!!");
      return supportedLocales.first;
    }
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBaseProvider<AppBloc>(
        builder: (context, appBloc) => appBloc ?? initAppBloc,
        onDispose: (context, appBloc) => appBloc.dispose(),
        child: ChangeNotifierProvider<AppLanguage>(
          create: (BuildContext context) => appLanguage,
          child: Consumer<AppLanguage>(
            builder: (context, appLang, child) {
              return MaterialApp(
                title: 'Exports Support',
                theme: _getTheme(),
                routes: _getRoute(),
                locale: appLang.appLocal,
                supportedLocales: LocaleCode.localCodes,
                localizationsDelegates: _getLocalDelegate(),
                localeResolutionCallback: _onLocaleResolution,
                debugShowCheckedModeBanner: false,
                home: NavScreen(),
              );
            },
          ),
        ));
  }
}
