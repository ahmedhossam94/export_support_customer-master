import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  late Locale _appLocale;

  Locale get appLocal => _appLocale ?? Locale('ar');

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('ar');
    } else {
      _appLocale = Locale(prefs.getString('language_code') ?? 'ar');
    }
    print(_appLocale);
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale('ar')) {
      _appLocale = Locale('ar');
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = Locale('en');
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
