import 'package:export_support_customer/Models/services_model.dart';

class PaintService {
  static PaintService instance = PaintService();
  ServiceCatagory generate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "دهانات";
    serviceCategory.nameEn = "Paints";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }
}