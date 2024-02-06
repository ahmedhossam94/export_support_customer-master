import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationModel {
  late String docID;
  late bool isActive;
  late String titleAr;
  late String titleEn;
  late String orderId;
  late String orderStatus;
  late String type;

  NotificationModel();

  _fromDocumentSnapshotToObject(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    this.docID = doc.id;
    this.isActive = data!["is_active"];
    this.titleAr = data["title_ar"];
    this.titleEn = data["title_en"];
    this.orderId = data["order_id"];
    this.orderStatus = data["order_status"];
    this.type = data["notification_type"];
  }

  NotificationModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    this._fromDocumentSnapshotToObject(doc);
  }

  static List<NotificationModel> fromDocumentSnapshotList(
      {@required List<DocumentSnapshot>? docList}) {
    List<NotificationModel> list = [];
    docList!.forEach((doc) {
      list.add(NotificationModel().._fromDocumentSnapshotToObject(doc));
    });
    return list;
  }
}
