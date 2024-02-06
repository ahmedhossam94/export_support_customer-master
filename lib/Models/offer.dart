import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Offer {
  String? docID = "";
  num? dateCreated = 0;
  num? dateUpdate = 0;
  num? endDate = 0;
  String? status = "";
  String? descAr = "";
  String? descEn = "";
  String? titleAr = "";
  String? titleEn = "";
  num? price = 0.0;
  num? quantity = 0;
  String? serviceCategoryID = "";
  String? serviceTypeID = "";
  String? mainServiceID = "";
  String? subMainServiceID = "";
  num? startDate = 0;
  String? serviceDetailsAr;
  String? serviceDetailsEn;
  String? offerType;

  Offer(
      {this.docID,
      this.dateCreated,
      this.dateUpdate,
      this.endDate,
      this.status,
      this.descAr,
      this.descEn,
      this.titleAr,
      this.titleEn,
      this.price,
      this.quantity,
      this.serviceCategoryID,
      this.serviceTypeID,
      this.mainServiceID,
      this.subMainServiceID,
      this.startDate,
      this.serviceDetailsAr,
      this.serviceDetailsEn,
      this.offerType});

  _fromDocumnetSnapshotToObject(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    this.docID = doc.id;
    this.dateCreated = data?["date_create"];
    this.dateUpdate = data?["date_update"];
    this.endDate = data?["end_date"];
    this.status = data?["status"];
    this.descAr = data?["offer_desc_ar"];
    this.descEn = data?["offer_desc_en"];
    this.titleAr = data?["offer_title_ar"];
    this.titleEn = data?["offer_title_en"];
    this.price = data?["price"];
    this.quantity = data?["qauntity"];
    this.serviceCategoryID = data?["service_category_id"];
    this.serviceTypeID = data?["service_type_id"];
    this.mainServiceID = data?["main_service_id"];
    this.subMainServiceID = data?["sub_main_service_id"];
    this.startDate = data?["start_date"];
    this.serviceDetailsAr = data?["service_details_ar"];
    this.serviceDetailsEn = data?["service_details_en"];
    this.offerType = data?["offer_type"];
  }

  Offer.fromMap(DocumentSnapshot doc) {
    this._fromDocumnetSnapshotToObject(doc);
  }

  static List<Offer> fromMapList({required List<DocumentSnapshot> dataList}) {
    List<Offer> list = [];
    dataList.forEach(
        (data) => list.add(Offer().._fromDocumnetSnapshotToObject(data)));
    return list;
  }
}
