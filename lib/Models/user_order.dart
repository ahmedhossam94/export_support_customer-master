import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:export_support_customer/HelperClass/data_converter.dart';
import 'package:export_support_customer/HelperClass/offer_status.dart';
import 'package:export_support_customer/HelperClass/order_status.dart';
import 'package:export_support_customer/Models/user_order_submit.dart';
import 'package:flutter/material.dart';

class UserOrder {
  late String docID;
  late String id;
  late String username;
  late String userPhone;
  late List<UserOrderService> services;
  late DateTime dateCreated;
  late DateTime dateUpdate;
  late String visitTime;
  late DateTime visitDate;
  late UserOrderLocation coordinate;
  late String comment;
  late List<String> imageUrl;
  late num discountPercent;
  late num totalDiscountAmount;
  late num totalPriceBeforeDiscount;
  late num totalPriceAfterDiscount;
  late num vatTotal;
  late num totalPriveWithVAT;
  late String orderStatus;
  late String workflowStatus;
  late DateTime fullDateAndTimeToVisit;
  late bool oneDayReminder;
  late bool oneHourRminder;
  late num moneyReceived;
  late num partsTotal;
  late num adminFees;
  late num vatPercentage;
  late String paymentMethod;
  late num adminDiscount;

  UserOrder();

  _fromDocumnetSnapshotToObject(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    int dateCreated = data!["order_date_created"];
    int dateUpdate = data["order_date_updated"];
    int visitedDate = data["visit_date"];
    int visitDateAndTimeTimestamp = data["visit_date_and_time"];
    DateTime? visitDateAndTime = visitDateAndTimeTimestamp != null
        ? DateConvert.instance.getDate(timestamp: visitDateAndTimeTimestamp)
        : null;

    this.docID = doc.id;
    this.id = data["order_id"];
    this.username = data["username"];
    this.userPhone = data["userPhone"];
    this.dateCreated = DateConvert.instance.getDate(timestamp: dateCreated);
    this.dateUpdate = DateConvert.instance.getDate(timestamp: dateUpdate);
    this.visitTime = data["visit_time"];
    this.visitDate = DateConvert.instance.getDate(timestamp: visitedDate);
    this.comment = data["comment"];
    this.discountPercent = data["discount_percent"];
    this.totalDiscountAmount = data["total_discount_amount"];
    this.totalPriceBeforeDiscount = data["total_order_price"];
    this.totalPriceAfterDiscount = data["total_order_price_after_discount"];
    this.vatTotal = data["VAT_total"];
    this.totalPriveWithVAT = data["total_price_with_VAT"];
    this.orderStatus = data["order_status"];
    this.workflowStatus = data["workflow_status"];
    this.fullDateAndTimeToVisit = visitDateAndTime!;
    this.oneDayReminder = data["one_day_reminder"];
    this.oneHourRminder = data["one_hour_reminder"];
    this.moneyReceived = data["money_received"];
    this.partsTotal = data["parts_total"];
    this.adminFees = data["administrative_fees"];
    this.vatPercentage = data["vat_percentage"];
    this.paymentMethod = data["payment_method"];
    this.adminDiscount = data["admin_discount"];

    this.services =
        UserOrderService.fromMapList(dataList: data["order_services"]);
    this.coordinate = UserOrderLocation.fromMap(data["visit_location"]);

    Map<dynamic, dynamic> imagesUrlMap = data["images_url"];
    this.imageUrl =
        imagesUrlMap.entries.map((data) => data.value.toString()).toList();
  }

  UserOrder.fromDocumentSnapshot(DocumentSnapshot doc) {
    this._fromDocumnetSnapshotToObject(doc);
  }

  static List<UserOrder> fromDocumentSnapshotList(
      {required List<DocumentSnapshot> docList}) {
    List<UserOrder> list = [];
    docList.forEach(
        (data) => list.add(UserOrder().._fromDocumnetSnapshotToObject(data)));
    return list;
  }

  Map<String, dynamic> toMapOnCreate(
      SubmittedOrder submittedOrder, String userID) {
    List<Map<String, dynamic>> serviceMapList = [];
    submittedOrder.services!.forEach((serv) {
      Map<String, dynamic> serviceMap = UserOrderService().toMapOnCreate(serv);
      serviceMapList.add(serviceMap);
    });

    return {
      "user_id": userID,
      "order_date_created":
          DateConvert.instance.getTimestamp(date: DateTime.now()),
      "order_date_updated":
          DateConvert.instance.getTimestamp(date: DateTime.now()),
      "order_services": serviceMapList,
      "visit_time": submittedOrder.visitTime,
      "visit_date":
          DateConvert.instance.getTimestamp(date: submittedOrder.visitDate!),
      "visit_location": {
        "latitude": submittedOrder.coordinate!.latitude,
        "longitude": submittedOrder.coordinate!.longitude
      },
      "comment": submittedOrder.comment,
      "images_url": {},
      "discount_percent": submittedOrder.discountPercent,
      "total_discount_amount": submittedOrder.totalDiscountAmount,
      "total_order_price": submittedOrder.totalPriceBeforeDiscount,
      "total_order_price_after_discount":
          submittedOrder.totalPriceAfterDiscount,
      "VAT_total": submittedOrder.vatTotal,
      "total_price_with_VAT": submittedOrder.totalPriveWithVAT,
      "order_status": OrderStatus.pending,
      "workflow_status": WorkflowStatus.pending,
      "one_day_reminder": submittedOrder.oneDayReminder,
      "one_hour_reminder": submittedOrder.oneHourRminder,
      "money_received": 0.0,
      "parts_total": 0.0,
      "administrative_fees": 0.0,
      "payment_method": submittedOrder.paymentMethod,
      "vat_percentage": submittedOrder.vatPercentage
    };
  }

  Map<String, dynamic> toMapOnUpdateOrderStatus(UserOrder userOrder) {
    return {"": ""};
  }
}

class UserOrderService {
  late String serviceCategoryId;
  late String mainServiceId;
  late String subMainServiceId;
  late bool isSubService;
  late String nameAr;
  late String nameEn;
  late num priceForOnePiece;
  late num totalPrice;
  late num quantity;
  late bool neededParts;
  late String offerServiceDetailsAr;
  late String offerServiceDetailsEn;
  late bool isPackageOffer;
  UserOrderService();

  _fromMapToObject(Map<dynamic, dynamic> data) {
    this.serviceCategoryId = data["service_category_id"];
    this.mainServiceId = data["main_service_id"];
    this.subMainServiceId = data["sub_main_service_id"];
    this.isSubService = data["is_sub_main_service"];
    this.nameAr = data["service_name_ar"];
    this.nameEn = data["service_name_en"];
    this.priceForOnePiece = data["price_for_one_piece"];
    this.totalPrice = data["total_price"];
    this.quantity = data["quantity"];
    this.neededParts = data["needed_parts"];
    this.offerServiceDetailsAr = data["offer_service_details_ar"];
    this.offerServiceDetailsEn = data["offer_dervice_details_en"];
    this.isPackageOffer = data["is_package_offer"];
  }

  UserOrderService.fromMap(Map<dynamic, dynamic> data) {
    this._fromMapToObject(data);
  }

  static List<UserOrderService> fromMapList({required List<dynamic> dataList}) {
    List<UserOrderService> list = [];
    dataList.forEach(
        (data) => list.add(UserOrderService().._fromMapToObject(data)));
    return list;
  }

  Map<String, dynamic> toMapOnCreate(SubmittedService submittedService) {
    bool isPackageOffer = submittedService.hasOffer &&
        submittedService.offerType == OfferType.packages;

    return {
      "service_category_id": submittedService.serviceCategoryId,
      "main_service_id": submittedService.mainServiceId,
      "sub_main_service_id": submittedService.subMainServiceId,
      "is_sub_main_service": submittedService.isSubService,
      "service_name_ar": isPackageOffer
          ? submittedService.offerNameAr
          : submittedService.nameAr,
      "service_name_en": isPackageOffer
          ? submittedService.offerNameEn
          : submittedService.nameEn,
      "price_for_one_piece": submittedService.priceForOnePiece,
      "total_price": submittedService.totalPrice,
      "quantity": submittedService.quantity,
      "needed_parts": submittedService.neededParts,
      "offer_service_details_ar":
          isPackageOffer ? submittedService.offerServiceDetailsAr : "",
      "offer_dervice_details_en":
          isPackageOffer ? submittedService.offerServiceDetailsEn : "",
      "is_package_offer": isPackageOffer
    };
  }
}

class UserOrderLocation {
  double? latitude;
  double? longitude;

  UserOrderLocation({required this.latitude, required this.longitude});

  _fromMapToObject(Map<dynamic, dynamic> data) {
    this.latitude = data["latitude"];
    this.longitude = data["longitude"];
  }

  UserOrderLocation.fromMap(Map<dynamic, dynamic> data) {
    this._fromMapToObject(data);
  }

  static List<UserOrderLocation> fromMapList(
      {required List<dynamic> dataList}) {
    List<UserOrderLocation> list = [];
    dataList.forEach((data) => list.add(
        UserOrderLocation(latitude: 0, longitude: 0).._fromMapToObject(data)));
    return list;
  }
}
