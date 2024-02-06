//import 'package:expert_support_admin/HelperClass/app_localizations.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderStatus {
  static final instance = OrderStatus();

  // ---------------- status to display ----------------------
  static const String inProcessEn = "Confirmed";
  static const String inProcessAr = "مؤكد";
  static const String doneEn = "Done";
  static const String doneAr = "منتهي";
  static const String canceledEn = "Canceled";
  static const String canceledAr = "ملغي";
  static const String pendingEn = "Received";
  static const String pendingAr = "تم استلام طلبك";
  static const String requestChangeEn = "Request Change";
  static const String requestChangeAr = "تعديل طلب";
  static const String onTheWayEn = "On The Way";
  static const String onTheWayAr = "في الطريق";
  static const String arrivedEn = "Technician Start Working";
  static const String arrivedAr = "الفني يشوف شغله";
  static const String unknownAr = "حالة غير معروفة";
  static const String unknownEn = "Unknow Status";

  // ---------------- database status -------------------------
  static const String inProcess = "InProcess";
  static const String done = "Done";
  static const String pending = "Pending";
  static const String canceled = "Canceled";
  static const String onTheWay = "OnTheWay";
  static const String arrived = "Arrived";
  static const String unknown = "unknow";

  String getDisplayStatus(
      {required String status, required BuildContext context}) {
    bool isArabic = AppLocalizations.of(context).isArabic();
    switch (status) {
      case inProcess:
        return isArabic ? inProcessAr : inProcessEn;
      case pending:
        return isArabic ? pendingAr : pendingEn;
      case done:
        return isArabic ? doneAr : doneEn;
      case canceled:
        return isArabic ? canceledAr : canceledEn;
      case onTheWay:
        return isArabic ? onTheWayAr : onTheWayEn;
      case arrived:
        return isArabic ? arrivedAr : arrivedEn;
      default:
        return isArabic ? unknownAr : unknownEn;
    }
  }

  Color getOrderStatusColor({required String status}) {
    switch (status) {
      case inProcess:
        return AppColor.purple;
      case pending:
        return AppColor.pink;
      case done:
        return Colors.green;
      case canceled:
        return AppColor.darkRed;
      case onTheWay:
        return AppColor.purple;
      case arrived:
        return AppColor.purple;
      default:
        return Colors.black;
    }
  }
}

class WorkflowStatus {
  static final instance = WorkflowStatus();

  // ---------------- status to display ----------------------
  static const String inProcessEn = "In process";
  static const String inProcessAr = "تحت المعالجة";
  static const String doneEn = "Done";
  static const String doneAr = "منجز";
  static const String canceledEn = "Canceled";
  static const String canceledAr = "ملغي";
  static const String pendingEn = "Pending";
  static const String pendingAr = "معلق";
  static const String requestChangeEn = "Request Change";
  static const String requestChangeAr = "طلب تعديل";
  static const String requestChangeReplyEn = "Request Change Reply";
  static const String requestChangeReplyAr = "الرد على طلب تعديل";
  static const String addNewServiceEn = "Added New Service";
  static const String addNewServiceAr = "اضافة خدمة جديدة";
  static const String onTheWayEn = "On The Way";
  static const String onTheWayAr = "في الطريق";
  static const String arrivedEn = "Technician Start Working";
  static const String arrivedAr = "الفني يشوف شغله";
  static const String unknownAr = "حالة غير معروفة";
  static const String unknownEn = "Unknow Status";

  // ---------------- database status -------------------------
  static const String inProcess = "InProcess";
  static const String done = "Done";
  static const String pending = "Pending";
  static const String canceled = "Canceled";
  static const String requestChange = "RequestChange";
  static const String requestChangeReply = "RequestChangeReply";
  static const String addNewService = "AddNewService";
  static const String onTheWay = "OnTheWay";
  static const String arrived = "Arrived";
  static const String unknown = "unknow";

  String getDisplayStatus(
      {required String status, required BuildContext context}) {
    bool isArabic = AppLocalizations.of(context).isArabic();
    switch (status) {
      case inProcess:
        return isArabic ? inProcessAr : inProcessEn;
      case pending:
        return isArabic ? pendingAr : pendingEn;
      case done:
        return isArabic ? doneAr : doneEn;
      case canceled:
        return isArabic ? canceledAr : canceledEn;
      case requestChange:
        return isArabic ? requestChangeAr : requestChangeEn;
      case requestChangeReply:
        return isArabic ? requestChangeReplyAr : requestChangeReplyEn;
      case addNewService:
        return isArabic ? addNewServiceAr : addNewServiceEn;
      case onTheWay:
        return isArabic ? onTheWayAr : onTheWayEn;
      case arrived:
        return isArabic ? arrivedAr : arrivedEn;
      default:
        return isArabic ? unknownAr : unknownEn;
    }
  }
}
