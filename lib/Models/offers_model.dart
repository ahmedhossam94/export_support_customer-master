import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:export_support_customer/HelperClass/data_converter.dart';

class OffersModel {
  late String id;
  late String serviceCategoryID;
  late String serviceTypeID;
  late String mainServiceID;
  late String subMainServiceID;
  late String titleAr;
  late String titleEn;
  late String descAr;
  late String descEn;
  late num priceForOne;
  late num qauntity;
  late String dateCreate;
  late num dateCreateTimestamp;
  late String dateUpdate;
  late num dateUpdateTimestamp;
  late String status;
  late num startDate;
  late num endDate;
  late num originalPrice;
  late String serviceDetailsAr;
  late String serviceDetailsEn;
  late String offerType;

  OffersModel();

  _fromDocumentSnapshotToObject(DocumentSnapshot offerDocData) {
    Map<String, dynamic>? offerData =
        offerDocData.data() as Map<String, dynamic>?;
    num dateCreate = offerData!["date_create"];
    num dateUpdate = offerData["date_update"];

    this.id = offerDocData.id;
    this.serviceCategoryID = offerData["service_category_id"];
    this.serviceTypeID = offerData["service_type_id"];
    this.mainServiceID = offerData["main_service_id"];
    this.subMainServiceID = offerData["sub_main_service_id"];
    this.titleAr = offerData["offer_title_ar"];
    this.titleEn = offerData["offer_title_en"];
    this.descAr = offerData["offer_desc_ar"];
    this.descEn = offerData["offer_desc_en"];
    this.priceForOne = offerData["price"];
    this.qauntity = offerData["qauntity"];
    this.dateCreate =
        DateConvert().toStringFromTimestamp(timestamp: dateCreate.toInt());
    this.dateCreateTimestamp = dateCreate;
    this.dateUpdate =
        DateConvert().toStringFromTimestamp(timestamp: dateUpdate.toInt());
    this.dateUpdateTimestamp = dateUpdate;
    this.status = offerData["status"];
    this.startDate = offerData["start_date"];
    this.endDate = offerData["end_date"];
    this.originalPrice = offerData["original_price"];
    this.serviceDetailsAr = offerData["service_details_ar"];
    this.serviceDetailsEn = offerData["service_details_en"];
    this.offerType = offerData["offer_type"];
  }

  OffersModel.fromDocumentSnapshot(DocumentSnapshot offerDocData) {
    this._fromDocumentSnapshotToObject(offerDocData);
  }

  static List<OffersModel> fromDocumentSnapshotList(
      {List<DocumentSnapshot>? offerDocDataList}) {
    List<OffersModel> offerList = [];
    offerDocDataList!.forEach((offerDocData) {
      offerList.add(OffersModel().._fromDocumentSnapshotToObject(offerDocData));
    });
    return offerList;
  }
}
