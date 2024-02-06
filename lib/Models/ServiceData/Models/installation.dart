import 'package:export_support_customer/Models/services_model.dart';

class InstallService {
  static InstallService instance = InstallService();
  ServiceCatagory generate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "تركيب";
    serviceCategory.nameEn = "Installation";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }
}