import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Services {
  List<ServiceCatagory> serviceList;

  Services({required this.serviceList});
}

class ServiceCatagory {
  late String docID;
  late String id;
  late String nameAr;
  late String nameEn;
  late Image icon;
  late bool isActive;
  late num order;
  late List<ServiceType> serviceTypeList;
  ServiceCatagory();

  _fromDocumnetSnapshotToObject(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    this.docID = doc.id;
    this.id = data!["ID"];
    this.nameAr = data["NameAr"];
    this.nameEn = data["NameEn"];
    this.isActive = data["IsActive"];
    this.order = data["Order"];

    this.serviceTypeList = ServiceType.fromMapList(dataList: data["Items"]);
  }

  ServiceCatagory.fromDocumentSnapshot(DocumentSnapshot doc) {
    this._fromDocumnetSnapshotToObject(doc);
  }

  static List<ServiceCatagory> fromDocumentSnapshotList(
      {required List<DocumentSnapshot> docList}) {
    List<ServiceCatagory> list = [];
    docList.forEach((doc) {
      // if (doc.data()?["Items"] is List<dynamic>) {
      //   list.add(ServiceCatagory().._fromDocumnetSnapshotToObject(doc));
      // }
    });
    return list;
  }
}

class ServiceType {
  late String id;
  late String nameAr;
  late String nameEn;
  late String descAr;
  late String descEn;
  late String remarkAr;
  late String remarkEn;
  late String optionsTitleAr;
  late String optionsTitleEn;
  late num gauranteePeriodInDays;
  late num minRate;
  late bool hasMainService;
  late String action;
  late List<MainService> mainServiceList;

  ServiceType();

  _fromMapToObject(Map<dynamic, dynamic> data) {
    this.id = data["ID"];
    this.nameAr = data["NameAr"];
    this.nameEn = data["NameEn"];
    this.descAr = data["DescAr"];
    this.descEn = data["DescEn"];
    this.remarkAr = data["RemarkAr"];
    this.remarkEn = data["RemarkEn"];
    this.optionsTitleAr = data["OptionsTitleAr"];
    this.optionsTitleEn = data["OptionsTitleEn"];
    this.gauranteePeriodInDays = data["GauranteePeriodInDays"];
    this.minRate = data["MinRate"];
    this.hasMainService = data["HasMainService"];
    this.action = data["Action"];

    this.mainServiceList = MainService.fromMapList(dataList: data["items"]);
  }

  ServiceType.fromMap(Map<dynamic, dynamic> data) {
    this._fromMapToObject(data);
  }

  static List<ServiceType> fromMapList({required List<dynamic> dataList}) {
    List<ServiceType> list = [];
    dataList.forEach((data) => list.add(ServiceType().._fromMapToObject(data)));
    return list;
  }
}

class MainService {
  late String id;
  late String nameAr;
  late String nameEn;
  late String type;
  late bool hasSub;
  late num price;
  late String priceDescAr;
  late String priceDescEn;
  late List<SubMainService> subMainServiceList;

  MainService();

  _fromMapToObject(Map<dynamic, dynamic> data) {
    this.id = data["ID"];
    this.nameAr = data["NameAr"];
    this.nameEn = data["NameEn"];
    this.type = data["Type"];
    this.hasSub = data["HasSub"];

    if (this.hasSub) {
      List<dynamic> priceMapList = data["SubMainService"];
      this.subMainServiceList =
          SubMainService.fromMapList(dataList: priceMapList);
    } else {
      this.price = data["Price"];
      this.priceDescAr = data["PriceDescAr"];
      this.priceDescEn = data["PriceDescEn"];
    }
  }

  MainService.fromMap(Map<dynamic, dynamic> data) {
    this._fromMapToObject(data);
  }

  static List<MainService> fromMapList({required List<dynamic> dataList}) {
    List<MainService> list = [];
    dataList.forEach((data) => list.add(MainService().._fromMapToObject(data)));
    return list;
  }
}

class SubMainService {
  late String id;
  late String nameAr;
  late String nameEn;
  late num price;
  late String priceDescAr;
  late String priceDescEn;

  SubMainService();

  _fromMapToObject(Map<dynamic, dynamic> data) {
    this.id = data["ID"];
    this.nameAr = data["NameAr"];
    this.nameEn = data["NameEn"];
    this.price = data["Price"];
    this.priceDescAr = data["PriceDescAr"];
    this.priceDescEn = data["PriceDescEn"];
  }

  SubMainService.fromMap(Map<dynamic, dynamic> data) {
    this._fromMapToObject(data);
  }

  static List<SubMainService> fromMapList({required List<dynamic> dataList}) {
    List<SubMainService> list = [];
    dataList
        .forEach((data) => list.add(SubMainService().._fromMapToObject(data)));
    return list;
  }
}

class ServiceCatagoryID {
  static const String airConditioner = "SERV01";
  static const String homeApplainces = "SERV02";
  static const String electric = "SERV03";
  static const String plumbing = "SERV04";
  static const String installing = "SERV05";
  static const String securityCamera = "SERV06";
  static const String paint = "SERV07";
  static const String floors = "SERV08";
  static const String cleaning = "SERV09";
  static const String elevator = "SERV10";
  static const String onlineShop = "SERV11";
}
