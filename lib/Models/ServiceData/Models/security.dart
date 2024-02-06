import 'package:export_support_customer/Models/services_model.dart';

class SecurityService {
  static SecurityService instance = SecurityService();
  ServiceCatagory generate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "انظمة الحماية";
    serviceCategory.nameEn = "Security Systems";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }
}