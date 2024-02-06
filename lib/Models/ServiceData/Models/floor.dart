import 'package:export_support_customer/Models/services_model.dart';

class FloorService {
  static FloorService instance = FloorService();
  ServiceCatagory generate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "ارضيات";
    serviceCategory.nameEn = "Floors";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }
}