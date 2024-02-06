import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:export_support_customer/HelperClass/data_converter.dart';
import 'package:export_support_customer/HelperClass/offer_status.dart';
import 'package:export_support_customer/HelperClass/order_status.dart';
import 'package:export_support_customer/Models/ServiceData/db_service.dart';
import 'package:export_support_customer/Models/user.dart';
import 'package:export_support_customer/Models/user_order.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CollectionName {
  CollectionReference fromCollection;
  CollectionReference toCollection;
  bool isNewDocID;

  CollectionName(
      {required this.fromCollection,
      required this.toCollection,
      this.isNewDocID = false});
}

class Database {
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static const bool isTestMode = false;
  //  StorageReference storageReference = FirebaseStorage.instance.ref();

  final servicesCollectoion =
      FirebaseFirestore.instance.collection("ServiceList");
  final servicesTestCollectoion =
      FirebaseFirestore.instance.collection("ServiceListTest");

  final usersCollectoion = FirebaseFirestore.instance.collection("Users");
  final usersTestCollectoion =
      FirebaseFirestore.instance.collection("UsersTest");

  final ordersListCollectoion =
      FirebaseFirestore.instance.collection("OrdersList");
  final ordersListTestCollectoion =
      FirebaseFirestore.instance.collection("OrdersListTest");

  final offersListCollectoion =
      FirebaseFirestore.instance.collection("OrderOffers");
  final offersListTestCollectoion =
      FirebaseFirestore.instance.collection("OrderOffersTest");

  final generalDetailsCollection =
      FirebaseFirestore.instance.collection("GeneralDetails");
  final generalDetailsTestCollection =
      FirebaseFirestore.instance.collection("GeneralDetailsTest");

  final userNotificationCollection =
      FirebaseFirestore.instance.collection("UserNotificationList");
  final userNotificationTestCollection =
      FirebaseFirestore.instance.collection("UserNotificationListTest");

  final dateAvailabilityCollection =
      FirebaseFirestore.instance.collection("DateAvailabilityLog");
  final dateAvailabilityTestCollection =
      FirebaseFirestore.instance.collection("DateAvailabilityLogTest");

  final discountCollection = FirebaseFirestore.instance.collection("Discount");
  final discountTestCollection =
      FirebaseFirestore.instance.collection("DiscountTest");

  updateDatabaseTest() async {
    List<CollectionName> collectionNameList = [
      CollectionName(
          fromCollection: generalDetailsTestCollection,
          toCollection: generalDetailsCollection),
    ];

    collectionNameList.forEach((c) async {
      QuerySnapshot querySnapshot = await c.fromCollection.get();
      querySnapshot.docs.forEach((doc) async {
        if (c.isNewDocID) {
          await c.toCollection.doc().set(doc.data());
        } else {
          await c.toCollection.doc(doc.id).set(doc.data());
        }
      });
    });
    print("done");
  }

  Future<QuerySnapshot> getServices() {
    if (isTestMode) {
      return servicesTestCollectoion.orderBy("Order").get();
    }
    return servicesCollectoion.orderBy("Order").get();
  }

  Future<QuerySnapshot> getOrderHistory({required String userID}) {
    if (isTestMode) {
      return ordersListTestCollectoion
          .where("user_id", isEqualTo: userID)
          .orderBy("order_date_created", descending: true)
          .get();
    }
    return ordersListCollectoion
        .where("user_id", isEqualTo: userID)
        .orderBy("order_date_created", descending: true)
        .get();
  }

  Future<QuerySnapshot> getUserInfoByPhone({required String phone}) {
    if (isTestMode) {
      return usersTestCollectoion.where("user_phone", isEqualTo: phone).get();
    }
    return usersCollectoion.where("user_phone", isEqualTo: phone).get();
  }

  Future<DocumentSnapshot> getUserInfoByID({required String id}) {
    if (isTestMode) {
      return usersTestCollectoion.doc(id).get();
    }
    return usersCollectoion.doc(id).get();
  }

  Future<void> saveUserInfo(UserModel user) {
    Map<String, dynamic> userMap = UserModel().toMap(user);

    if (isTestMode) {
      return usersTestCollectoion.doc(user.id).set(userMap);
    }
    return usersCollectoion.doc(user.id).set(userMap);
  }

  Future<QuerySnapshot> getOffers() {
    if (isTestMode) {
      return offersListTestCollectoion
          .where("status", isEqualTo: OfferStatus.active)
          .orderBy("date_update", descending: true)
          .get();
    }
    return offersListCollectoion
        .where("status", isEqualTo: OfferStatus.active)
        .orderBy("date_update", descending: true)
        .get();
  }

  Future<QuerySnapshot> getOfferIfAvailable(
      String mainServiceID, String subMainSerivceID, bool isSub) {
    final String whereFieldKey =
        isSub ? "sub_main_service_id" : "main_service_id";
    final String whereFieldValue = isSub ? subMainSerivceID : mainServiceID;

    if (isTestMode) {
      return offersListTestCollectoion
          .where("status", isEqualTo: OfferStatus.active)
          .where(whereFieldKey, isEqualTo: whereFieldValue)
          .orderBy("date_update", descending: true)
          .get();
    }
    return offersListCollectoion
        .where("status", isEqualTo: OfferStatus.active)
        .where(whereFieldKey, isEqualTo: whereFieldValue)
        .orderBy("date_update", descending: true)
        .get();
  }

  Future<QuerySnapshot> getGeneralDetails() {
    if (isTestMode) {
      return generalDetailsTestCollection.get();
    }
    return generalDetailsCollection.get();
  }

  Future<QuerySnapshot> getNotification({required String userID}) {
    if (isTestMode) {
      return userNotificationTestCollection
          .where("is_active", isEqualTo: true)
          .where("user_id", isEqualTo: userID)
          .orderBy("date_created", descending: true)
          .get();
    }
    return userNotificationCollection
        .where("is_active", isEqualTo: true)
        .where("user_id", isEqualTo: userID)
        .orderBy("date_created", descending: true)
        .get();
  }

  Future<QuerySnapshot> getDateAvailability() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    var todayTimestamp = today.millisecondsSinceEpoch;

    if (isTestMode) {
      return dateAvailabilityTestCollection
          .where("timestamp", isGreaterThanOrEqualTo: todayTimestamp)
          .get();
    }
    return dateAvailabilityCollection
        .where("timestamp", isGreaterThanOrEqualTo: todayTimestamp)
        .get();
  }

  Future<DocumentSnapshot> getOrderLimit() {
    if (isTestMode) {
      return generalDetailsTestCollection.doc("orderLimit").get();
    }
    return generalDetailsCollection.doc("orderLimit").get();
  }

  Future<QuerySnapshot> getDiscountCode(String code) {
    if (isTestMode) {
      return discountTestCollection
          .where("code", isEqualTo: code)
          .where("is_valid", isEqualTo: true)
          //.orderBy("date_update", descending: true)
          .get();
    }
    return discountCollection
        .where("code", isEqualTo: code)
        .where("is_valid", isEqualTo: true)
        //.orderBy("date_update", descending: true)
        .get();
  }

  Future<void> saveOrder(SubmittedOrder submittedOrder, String userID,
      Function() onSuccess, Function(String) onError) {
    Map<String, dynamic> submittedOrderMap =
        UserOrder().toMapOnCreate(submittedOrder, userID);
    CollectionReference orderCollectionReference =
        isTestMode ? ordersListTestCollectoion : ordersListCollectoion;
    CollectionReference dateLogCollectionReference = isTestMode
        ? dateAvailabilityTestCollection
        : dateAvailabilityCollection;
    WriteBatch batch = db.batch();

    String docID = orderCollectionReference.doc().id;

    batch.set(orderCollectionReference.doc(docID), submittedOrderMap);

    int timestamp =
        DateConvert.instance.getTimestamp(date: submittedOrder.visitDate!);
    submittedOrder.services!.forEach((serv) {
      if (serv.serviceCategoryId!.isNotEmpty || serv.serviceCategoryId != "") {
        Map<String, dynamic> dataLogMap = {
          "timestamp": timestamp,
          serv.serviceCategoryId!: FieldValue.arrayUnion([docID])
        };

        batch.set(
            dateLogCollectionReference.doc(timestamp.toString()), dataLogMap);
      }
    });

    return batch.commit().then((onValue) {
      if (submittedOrder.images != null && submittedOrder.images!.length > 0) {
        uploadImage(docID, submittedOrder.images!).then((imagesUrlList) {
          Map<String, dynamic> urlListMap = imagesUrlList
              .asMap()
              .map<String, dynamic>((i, url) => MapEntry("image${i + 1}", url));
          Map<String, dynamic> imagesListMap = {"images_url": urlListMap};
          orderCollectionReference.doc(docID).update(imagesListMap);
        }).catchError((onError) {
          print("Could not upload images");
        });
      }
      onSuccess();
    }).catchError((onError) {
      onError(onError.toString());
    });
  }

  Future<QuerySnapshot> getOrderNotComplete({required String userID}) {
    if (isTestMode) {
      return ordersListTestCollectoion
          .where("user_id", isEqualTo: userID)
          .where("order_status", whereIn: [
        OrderStatus.pending,
        OrderStatus.inProcess,
        OrderStatus.onTheWay,
        OrderStatus.arrived
      ]).get();
    }
    return ordersListCollectoion
        .where("user_id", isEqualTo: userID)
        .where("order_status", whereIn: [
      OrderStatus.pending,
      OrderStatus.inProcess,
      OrderStatus.onTheWay,
      OrderStatus.arrived
    ]).get();
  }

  Future<void> cancelOrder(UserOrder order) {
    CollectionReference orderCollectionReference =
        isTestMode ? ordersListTestCollectoion : ordersListCollectoion;
    CollectionReference dateLogCollectionReference = isTestMode
        ? dateAvailabilityTestCollection
        : dateAvailabilityCollection;
    WriteBatch batch = db.batch();

    int orderVisitDateTimestamp =
        DateConvert.instance.getTimestamp(date: order.visitDate);

    DocumentReference orderDocRef = orderCollectionReference.doc(order.docID);
    DocumentReference dateLogDocRef =
        dateLogCollectionReference.doc("$orderVisitDateTimestamp");

    batch.update(orderDocRef, {
      "order_status": OrderStatus.canceled,
      "workflow_status": WorkflowStatus.canceled
    });

    order.services.forEach((s) {
      batch.update(dateLogDocRef, {
        s.serviceCategoryId: FieldValue.arrayRemove([order.docID])
      });
    });

    return batch.commit();
  }

  Future<void> updateUserFCMToken(String userDocID, String fcmToken) {
    Map<String, dynamic> userMap = UserModel().toMapOnUpdateFCMToken(fcmToken);

    if (isTestMode) {
      return usersTestCollectoion.doc(userDocID).update(userMap);
    }
    return usersCollectoion.doc(userDocID).update(userMap);
  }

  Future<void> updateUserlang(String userDocID, String lang) {
    Map<String, dynamic> userMap = UserModel().toMapOnUpdateLang(lang);

    if (isTestMode) {
      return usersTestCollectoion.doc(userDocID).update(userMap);
    }
    return usersCollectoion.doc(userDocID).update(userMap);
  }

  // -------------------------- Storage ----------------------------- //

  Future<List<String>> uploadImage(
      String docID, List<File> imageFileList) async {
    List<String> uploadUrlList = [];

    await Future.wait(imageFileList.map((File imageFile) async {
      // if (imageFile != null) {
      //   DateTime now = DateTime.now();
      //   StorageReference ref = isTestMode
      //       ? storageReference.child("OrderImagesTest/")
      //       : storageReference.child("OrderImages/");
      //   StorageReference childRef = ref.child(docID);
      //   StorageUploadTask storageUploadTask = childRef
      //       .child(
      //           "ORDER-IMAGE-${now.year}-${now.month}-${now.day}-${imageFile.uri.pathSegments.last}")
      //       .putFile(imageFile);

      //   if (storageUploadTask.isSuccessful && storageUploadTask.isComplete) {
      //     final String url = await ref.getDownloadURL();
      //     uploadUrlList.add(url);
      //     print("The downloaded url on cmplete and success: $url");
      //   } else if (storageUploadTask.isInProgress) {
      //     StorageTaskSnapshot storageTaskSnapshot =
      //         await storageUploadTask.onComplete;
      //     String url = await storageTaskSnapshot.ref.getDownloadURL();
      //     uploadUrlList.add(url);
      //     print("The downloaded url after task finish: $url");
      //   }
      // }
    }));

    return uploadUrlList;
  }

  // -------------------------------------------------------------- //

  // -------------------------- Service List ----------------------------- //

  setServices() async {
    CollectionReference collectionRef =
        isTestMode ? servicesTestCollectoion : servicesCollectoion;

    QuerySnapshot query = await collectionRef.get();
    if (query.docs.isNotEmpty) {
      for (DocumentSnapshot doc in query.docs) {
        collectionRef.doc(doc.id).delete();
      }
    }

    List<Map<String, dynamic>> serviceMapList =
        DBService().generateServicesMap();
    serviceMapList.forEach((serviceMap) async {
      DocumentReference docRef = collectionRef.doc();
      await docRef.set(serviceMap);
      print(
          "Service \"${serviceMap["ID"]}\" has been set successfully. isTest = $isTestMode");
    });
  }

  // --------------------------------------------------------------------- //
}
