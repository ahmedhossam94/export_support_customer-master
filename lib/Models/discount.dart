import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Discount {
  late String docID;
  late String code;
  late num percentage;
  late bool isValid;
  late num dateUpdate;
  late num dateCreated;

  Discount();

  _fromDocumentSnapshotToObject(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    this.docID = doc.id;
    this.code = data!["code"];
    this.percentage = data["percent"];
    this.isValid = data["is_valid"];
    this.dateCreated = data["date_create"];
    this.dateUpdate = data["date_update"];
  }

  Discount.fromDocumentSnapshot(DocumentSnapshot doc) {
    this._fromDocumentSnapshotToObject(doc);
  }

  static List<Discount> fromMapList(
      {required List<DocumentSnapshot> dataList}) {
    List<Discount> list = [];
    dataList.forEach(
        (data) => list.add(Discount().._fromDocumentSnapshotToObject(data)));
    return list;
  }
}
