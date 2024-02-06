import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:export_support_customer/FirebaseResources/firebase_manager.dart';
import 'package:export_support_customer/Models/discount.dart';
import 'package:export_support_customer/Models/general_details.dart';
import 'package:export_support_customer/Models/offer.dart';
import 'package:export_support_customer/Models/unavailable_date.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubmittedOrderBloc {
  FirebaseManager _firebaseManager = FirebaseManager();

  Future<Offer> getOfferIfAvaible(
      {required String mainServiceID,
      required subMainSerivceID,
      required bool isSub}) async {
    try {
      final QuerySnapshot offerDocs = await _firebaseManager
          .getOfferIfAvailable(mainServiceID, subMainSerivceID, isSub);
      if (offerDocs.docs.isNotEmpty) {
        Offer offer = Offer.fromMap(offerDocs.docs.first);
        return offer;
      }
      throw '';
    } on PlatformException catch (_) {
      throw '';
    }
  }

  Future<UnavailableDate> getUnavailableDate() async {
    try {
      UnavailableDate unavailableDate = UnavailableDate();
      unavailableDate.timestampList = [];

      QuerySnapshot dateLogSnapshot =
          await _firebaseManager.getDateAvailability();
      DocumentSnapshot orderLimitDoc = await _firebaseManager.getOrderLimit();

      OrderLimit orderLimit =
          OrderLimit.fromMap(orderLimitDoc.data() as Map<String, dynamic>);
      unavailableDate.startDateTimestamp =
          orderLimit.unavaliableStartDateTimestamp;
      unavailableDate.endDateTimestamp = orderLimit.unavaliableEndDateTimestamp;

      dateLogSnapshot.docs.forEach((d) {
        Map<String, dynamic>? data = d.data() as Map<String, dynamic>?;
        int timestamp = data!["timestamp"];

        data.values.forEach((v) {
          if (v is List<dynamic>) {
            if (v.length >= orderLimit.perDay) {
              unavailableDate.timestampList!.add(timestamp);
            }
          }
        });
      });

      return unavailableDate;
    } on PlatformException catch (_) {
      throw '';
    }
  }

  Future<Discount> getDiscountCode(String code) async {
    try {
      QuerySnapshot discountCodeSnapshot =
          await _firebaseManager.getDiscountCode(code: code);
      if (discountCodeSnapshot.docs.isEmpty) {
        throw '';
      }
      return Discount.fromMapList(dataList: discountCodeSnapshot.docs).first;
    } on PlatformException catch (_) {
      throw '';
    }
  }

  Future<String> isUserSignedIn() async {
    try {
      User user = await _firebaseManager.getUser();
      if (user != null) {
        DocumentSnapshot userInfo =
            await _firebaseManager.getUserInfoByID(id: user.uid);
        if (userInfo.exists) {
          return user.uid;
        }
      }
      throw '';
    } on PlatformException catch (_) {
      throw '';
    }
  }

  Future<bool> canSubmitOrder(
      {required String userID, required Function(String) onError}) async {
    try {
      QuerySnapshot orderNotComplete =
          await _firebaseManager.getOrderNotComplete(userID: userID);

      if (orderNotComplete != null && orderNotComplete.docs.length > 0) {
        return false;
      }
      return true;
    } on PlatformException catch (e) {
      onError(e.message ?? '');
      throw '';
    }
  }

  Future<void> saveOrder(
      {required SubmittedOrder submittedOrder,
      required String userID,
      required Function() onSuccess,
      required Function(String) onError}) async {
    try {
      await _firebaseManager.saveOrder(
          submittedOrder: submittedOrder,
          userID: userID,
          onSuccess: onSuccess,
          onError: onError);
    } on PlatformException catch (e) {
      onError(e.message ?? '');
    }
  }
}
