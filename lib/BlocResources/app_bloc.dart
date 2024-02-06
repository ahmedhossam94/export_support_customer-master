import 'dart:async';
import 'package:export_support_customer/Models/general_details.dart';
import 'package:export_support_customer/Models/user.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:rxdart/rxdart.dart';

import 'package:export_support_customer/FirebaseResources/firebase_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:export_support_customer/Models/services_model.dart';

class AppBloc {
  FirebaseManager _firebaseManager = FirebaseManager();
  final BehaviorSubject<Services> _services = BehaviorSubject<Services>();
  final BehaviorSubject<UserModel> _user = BehaviorSubject<UserModel>();
  final BehaviorSubject<String> _fcmToken = BehaviorSubject();

  Services services = Services(serviceList: []);
  GeneralDetails generalDetails = GeneralDetails();
  SubmittedOrder submittedOrder = SubmittedOrder();
  bool isAddNewService = false;

  Future<QuerySnapshot> get getServices => _firebaseManager.getServices();

  // Stream<Services> get services => _services.stream;
  // Sink<Services> get setServices => _services.sink;

  Stream<UserModel> get user => _user.stream;
  Sink<UserModel> get setUser => _user.sink;

  Stream<String> get fcmToken => _fcmToken.stream;
  Sink<String> get setFCMToken => _fcmToken.sink;

  setServiceInfo(QuerySnapshot querySnapshot) {
    services.serviceList =
        ServiceCatagory.fromDocumentSnapshotList(docList: querySnapshot.docs);
  }

  setGeneralDetails(QuerySnapshot querySnapshot) {
    generalDetails =
        GeneralDetails.fromDocumentSnapshotList(docList: querySnapshot.docs);
  }

  Future<void> updateUserInfoIfExist() async {
    final user = await _firebaseManager.getUser();
    if (user != null) {
      final userDoc = await _firebaseManager.getUserInfoByID(id: user.uid);
      if (userDoc.data != null) {
        UserModel userInfo = UserModel.fromDocumentSnapshot(userDoc);
        _user.sink.add(userInfo);
      }
    }
  }

  Future<void> updateUserFCMTokenOnSignIn() async {
    UserModel user = _user.value;
    String fcmToken = _fcmToken.value != null ? _fcmToken.value : "";

    if (user != null) {
      await _firebaseManager.updateUserFCMToken(
          userDocID: user.id!, fcmToken: fcmToken);
    }
  }

  Future<void> updateUserFCMTokenOnSignOut() async {
    UserModel user = _user.value;

    if (user != null) {
      await _firebaseManager.updateUserFCMToken(
          userDocID: user.id!, fcmToken: "");
    }
  }

  Future<void> updateUserlangOnChangeLang(String lang) async {
    UserModel user = _user.value;

    if (user != null) {
      await _firebaseManager.updateUserlang(userDocID: user.id!, lang: lang);
    }
  }

  Future<void> signOut() {
    return _firebaseManager.signOut();
  }

  dispose() {
    _services.close();
    _user.close();
    _fcmToken.close();
  }
}
