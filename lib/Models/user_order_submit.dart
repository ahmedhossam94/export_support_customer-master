import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class SubmittedOrder {
  List<SubmittedService>? services;
  List<File>? images; // handle images
  String comment = "";
  String? visitTime;
  DateTime? visitDate;
  String? address;
  LatLng? coordinate;
  num discountPercent = 0.0;
  num totalDiscountAmount = 0.0;
  num totalPriceBeforeDiscount = 0.0;
  num totalPriceAfterDiscount = 0.0;
  num currentTotal = 0.0;
  num vatTotal = 0.0;
  num totalPriveWithVAT = 0.0;
  bool oneDayReminder = false;
  bool oneHourRminder = false;
  String? paymentMethod;
  num? vatPercentage;
}

class SubmittedService {
  String? serviceCategoryId;
  String? mainServiceId;
  String? subMainServiceId;
  bool? isSubService;
  String? nameAr;
  String? nameEn;
  num? priceForOnePiece;
  num? totalPrice;
  num quantity = 1;
  bool neededParts = false;
  bool hasOffer = false;
  num? offerPrice;
  num? offerQuantity;
  String? offerType;
  String? offerNameAr;
  String? offerNameEn;
  String? offerDescAr;
  String? offerDescEn;
  String? offerServiceDetailsAr;
  String? offerServiceDetailsEn;
}

class VisitTime {
  static const String morning = "Morning";
  static const String evening = "Evening";
}
