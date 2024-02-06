import 'package:export_support_customer/Models/services_model.dart';

class ElevatorService {
  static ElevatorService instance = ElevatorService();
  ServiceCatagory generate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "المصاعد";
    serviceCategory.nameEn = "Elevators";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }
}