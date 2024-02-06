import 'package:export_support_customer/Models/services_model.dart';

class CleanService {
  static CleanService instance = CleanService();
  ServiceCatagory generate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "تنظيف";
    serviceCategory.nameEn = "Cleaning";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }
}