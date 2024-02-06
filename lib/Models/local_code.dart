import 'dart:ui';

class LocaleCode{
  static const String languageCodeAr = "ar";
  static const String languageCodeEn = "en";
  static const String countryCodeAr = "SA";
  static const String countryCodeEn = "US";

  static const Locale englishLocale = Locale('en');
  static const Locale arabicLocale = Locale('ar');

  static const List<Locale> localCodes = [
    Locale('ar', ''), //All Arabic Country
    Locale('en', 'US'), //United States
    // Locale('ar', 'SA'), //KSA
    // Locale('ar', 'YE'), //Yemen
    // Locale('ar', 'DH'), //Bahrain
    // Locale('ar', 'EG'), //Egypt
    // Locale('ar', 'KW'), //Kuwait
    // Locale('ar', 'OM'), //Oman
    // Locale('ar', 'QA'), //Qatar
    // Locale('ar', 'AE'), //United Arab Emirates
  ];
}