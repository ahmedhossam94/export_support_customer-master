import 'package:export_support_customer/Models/services_model.dart';

class HomeApplaincesService {
  static HomeApplaincesService instance = HomeApplaincesService();
  ServiceCatagory generate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "أجهزة منزلية";
    serviceCategory.nameEn = "Home Applainces";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }
}