import 'package:export_support_customer/Models/user.dart';
import 'package:export_support_customer/Models/user_order.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:export_support_customer/FirebaseResources/auth.dart';
import 'package:export_support_customer/FirebaseResources/database.dart';

class FirebaseManager {
  final _auth = Auth();
  final _db = Database();

  // -------------------------- Auth ----------------------------- //

  Future<User> getUser() {
    return _auth.getUser();
  }

  Future<void> sendVerifyCode(
      String phone,
      Function(AuthCredential) onAutoRetrieveVerify,
      Function(String) onError,
      Function(String, int) onSuccess,
      Function(String) onAutoRetrieveTimeout,
      {int? forceCodeResend}) {
    return _auth.sendVerifyCode(
        phone, onAutoRetrieveVerify, onError, onSuccess, onAutoRetrieveTimeout,
        forceCodeResend: forceCodeResend ?? 0);
  }

  Future<void> signIn({
    required String verificationId,
    required String smsCode,
    required AuthCredential autoRetrieveAuthCredential,
    required Function(User) onSuccess,
    required Function(String) onError,
  }) {
    return _auth.signIn(
        verificationId: verificationId,
        smsCode: smsCode,
        autoRetrieveAuthCredential: autoRetrieveAuthCredential,
        onSuccess: onSuccess,
        onError: onError);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  // ------------------------ End Auth --------------------------- //

  // ------------------------ Database --------------------------- //

  updateDatabaseTest() {
    _db.updateDatabaseTest();
  }

  Future<QuerySnapshot> getServices() {
    return _db.getServices();
  }

  Future<QuerySnapshot> getOrderHistory() async {
    final user = await this.getUser();

    if (user != null) {
      return _db.getOrderHistory(userID: user.uid);
    }
    throw '';
  }

  Future<QuerySnapshot> getUserInfoByPhone({required String phone}) {
    return _db.getUserInfoByPhone(phone: phone);
  }

  Future<DocumentSnapshot> getUserInfoByID({required String id}) {
    return _db.getUserInfoByID(id: id);
  }

  Future<void> saveUserInfo(UserModel user) {
    return _db.saveUserInfo(user);
  }

  Future<QuerySnapshot> getOffers() {
    return _db.getOffers();
  }

  Future<QuerySnapshot> getOfferIfAvailable(
      String mainServiceID, String subMainSerivceID, bool isSub) {
    return _db.getOfferIfAvailable(mainServiceID, subMainSerivceID, isSub);
  }

  Future<QuerySnapshot> getGeneralDetails() {
    return _db.getGeneralDetails();
  }

  Future<QuerySnapshot> getNotification() async {
    final user = await this.getUser();

    if (user != null) {
      return _db.getNotification(userID: user.uid);
    }
    throw '';
  }

  Future<QuerySnapshot> getDateAvailability() {
    return _db.getDateAvailability();
  }

  Future<DocumentSnapshot> getOrderLimit() {
    return _db.getOrderLimit();
  }

  Future<QuerySnapshot> getDiscountCode({required String code}) {
    return _db.getDiscountCode(code);
  }

  Future<void> saveOrder(
      {required SubmittedOrder submittedOrder,
      required String userID,
      Function()? onSuccess,
      Function(String)? onError}) {
    return _db.saveOrder(submittedOrder, userID, onSuccess!, onError!);
  }

  Future<QuerySnapshot> getOrderNotComplete({required String userID}) {
    return _db.getOrderNotComplete(userID: userID);
  }

  Future<void> cancelOrder({required UserOrder order}) {
    return _db.cancelOrder(order);
  }

  Future<void> updateUserFCMToken(
      {required String userDocID, required String fcmToken}) {
    return _db.updateUserFCMToken(userDocID, fcmToken);
  }

  Future<void> updateUserlang(
      {required String userDocID, required String lang}) {
    return _db.updateUserlang(userDocID, lang);
  }

  setServices() {
    _db.setServices();
  }
  // ---------------------- End Database ------------------------- //
}
