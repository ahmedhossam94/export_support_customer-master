import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralDetails {
  late AboutUs aboutUs;
  late Shared shared;
  late SubmitOrder submitOrder;
  late OrderLimit orderLimit;

  GeneralDetails();

  _fromDocumentSnapshotToObject(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    switch (doc.id) {
      case "ContactUs":
        this.aboutUs = AboutUs.fromMap(data!);
        break;

      case "Shared":
        this.shared = Shared.fromMap(data!);
        break;

      case "SubmitOrder":
        this.submitOrder = SubmitOrder.fromMap(data!);
        break;

      case "orderLimit":
        this.orderLimit = OrderLimit.fromMap(data!);
        break;

      default:
        break;
    }
  }

  GeneralDetails.fromDocumentSnapshot(DocumentSnapshot doc) {
    this._fromDocumentSnapshotToObject(doc);
  }

  static GeneralDetails fromDocumentSnapshotList(
      {@required List<DocumentSnapshot>? docList}) {
    GeneralDetails details = GeneralDetails();
    docList!.forEach((doc) {
      details._fromDocumentSnapshotToObject(doc);
    });
    return details;
  }
}

class AboutUs {
  late String headerAr;
  late String headerEn;
  late String aboutUsAr;
  late String aboutUsEn;
  late String phone;
  late String twitter;
  late String instagram;
  late String facebook;

  AboutUs();

  _fromMapToObject(Map<dynamic, dynamic> data) {
    this.headerAr = data["header_ar"];
    this.headerEn = data["header_en"];
    this.aboutUsAr = data["about_us_ar"];
    this.aboutUsEn = data["about_us_en"];
    this.phone = data["phone"];
    this.twitter = data["twitter"];
    this.instagram = data["instagram"];
    this.facebook = data["facebook"];
  }

  AboutUs.fromMap(Map<dynamic, dynamic> data) {
    this._fromMapToObject(data);
  }

  static List<AboutUs> fromMapList({@required List<dynamic>? dataList}) {
    List<AboutUs> list = [];
    dataList!.forEach((data) => list.add(AboutUs().._fromMapToObject(data)));
    return list;
  }
}

class Shared {
  late String link;
  late String linkAndroid;

  Shared();

  _fromMapToObject(Map<dynamic, dynamic> data) {
    this.link = data["link"];
    this.linkAndroid = data["link_android"];
  }

  Shared.fromMap(Map<dynamic, dynamic> data) {
    this._fromMapToObject(data);
  }

  static List<Shared> fromMapList({required List<dynamic> dataList}) {
    List<Shared> list = [];
    dataList.forEach((data) => list.add(Shared().._fromMapToObject(data)));
    return list;
  }
}

class SubmitOrder {
  late List<TermsAndConditions> termsAndConditions;
  late num limitRate;
  late bool isCashEnabled;
  late bool isPOSEnabled;
  late num vatPercentage;
  late String vatPriceNoteAr;
  late String vatPriceNoteEn;
  late bool canShowVatNote;

  SubmitOrder();

  _fromMapToObject(Map<dynamic, dynamic> data) {
    this.termsAndConditions =
        TermsAndConditions.fromMapList(dataList: data["TermsConditions"]);
    this.limitRate = data["limit_rate"];
    this.isCashEnabled = data["is_cash_enabled"];
    this.isPOSEnabled = data["is_pos_enabled"];
    this.vatPercentage = data["VAT_percentage"];
    this.vatPriceNoteAr = data["vat_price_note_ar"];
    this.vatPriceNoteEn = data["vat_price_note_en"];
    this.canShowVatNote = data["can_show_vat_note"];
  }

  SubmitOrder.fromMap(Map<dynamic, dynamic> data) {
    this._fromMapToObject(data);
  }

  static List<SubmitOrder> fromMapList({required List<dynamic> dataList}) {
    List<SubmitOrder> list = [];
    dataList.forEach((data) => list.add(SubmitOrder().._fromMapToObject(data)));
    return list;
  }
}

class TermsAndConditions {
  late String textAr;
  late String textEn;

  TermsAndConditions();

  _fromMapToObject(Map<dynamic, dynamic> data) {
    this.textAr = data["text_ar"];
    this.textEn = data["text_en"];
  }

  TermsAndConditions.fromMap(Map<dynamic, dynamic> data) {
    this._fromMapToObject(data);
  }

  static List<TermsAndConditions> fromMapList(
      {required List<dynamic> dataList}) {
    List<TermsAndConditions> list = [];
    dataList.forEach(
        (data) => list.add(TermsAndConditions().._fromMapToObject(data)));
    return list;
  }
}

class OrderLimit {
  late int perDay;
  late int unavaliableStartDateTimestamp;
  late int unavaliableEndDateTimestamp;

  OrderLimit();

  _fromMapToObject(Map<dynamic, dynamic> data) {
    this.perDay = data["per_day"];
    this.unavaliableStartDateTimestamp = data["unavailable_start_date"];
    this.unavaliableEndDateTimestamp = data["unavailable_end_date"];
  }

  OrderLimit.fromMap(Map<dynamic, dynamic> data) {
    this._fromMapToObject(data);
  }

  static List<OrderLimit> fromMapList({required List<dynamic> dataList}) {
    List<OrderLimit> list = [];
    dataList.forEach((data) => list.add(OrderLimit().._fromMapToObject(data)));
    return list;
  }
}
