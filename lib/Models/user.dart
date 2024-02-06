import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? phone;
  String? name;
  num? memberID;
  num? dateCreated;
  String? fcmToken;
  String? preferredLand;
  bool? isNew;

  UserModel(
      {this.id,
      this.phone,
      this.name,
      this.memberID,
      this.dateCreated,
      this.isNew,
      this.fcmToken,
      this.preferredLand});

  _fromDocumnetSnapshotToObject(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    this.id = doc.id;
    this.memberID = data?["member_id"];
    this.phone = data?["user_phone"];
    this.name = data?["username"];
    this.dateCreated = data?["date_create"];
    this.preferredLand = data?["prederred_lang"];
    this.fcmToken = data?["fcm_token"];
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    this._fromDocumnetSnapshotToObject(doc);
  }

  Map<String, dynamic> toMap(UserModel user) {
    return {
      "user_phone": user.phone,
      "username": user.name,
      "date_create": user.dateCreated,
      "prederred_lang": user.preferredLand,
      "fcm_token": ''
    };
  }

  Map<String, dynamic> toMapOnUpdateLang(String lang) {
    return {
      "prederred_lang": lang,
    };
  }

  Map<String, dynamic> toMapOnUpdateFCMToken(String fcmToken) {
    return {"fcm_token": fcmToken};
  }
}
