import 'package:export_support_customer/Models/services_model.dart';

class StoreService {
  static StoreService instance = StoreService();
  ServiceCatagory generate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "المتجر";
    serviceCategory.nameEn = "Online Store";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }
}