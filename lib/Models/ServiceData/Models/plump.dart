import 'package:export_support_customer/Models/main_service_type.dart';
import 'package:export_support_customer/Models/service_type_action.dart';
import 'package:export_support_customer/Models/services_model.dart';

class PlumpService {
  static PlumpService instance = PlumpService();
  ServiceCatagory generate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "سباكة";
    serviceCategory.nameEn = "Plumbing";
    serviceCategory.isActive = true;
    serviceCategory.serviceTypeList = [
      _getPlumpServiceType1(),
      _getPlumpServiceType2(),
      _getPlumpServiceType3(),
      _getPlumpServiceType4(),
      _getPlumpServiceType5(),
      _getPlumpServiceType6(),
      _getPlumpServiceType7(),
      _getPlumpServiceType8(),
      _getPlumpServiceType9(),
    ];
    return serviceCategory;
  }

  ServiceType _getPlumpServiceType1() {
    var serviceType = ServiceType();
    serviceType.nameAr = "المغاسل";
    serviceType.nameEn = "Sink";
    serviceType.descAr = "";
    serviceType.descEn = "";
    serviceType.optionsTitleEn = "";
    serviceType.optionsTitleAr = "";
    serviceType.remarkAr = "";
    serviceType.remarkEn = "";
    serviceType.gauranteePeriodInDays = 30;
    serviceType.minRate = 50.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var mainService =
        PlumpMainService.instance.getMainService("المغاسل", "Sink");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getPlumpServiceType2() {
    var serviceType = ServiceType();
    serviceType.nameAr = "المراحيض";
    serviceType.nameEn = "Toilets";
    serviceType.descAr = "";
    serviceType.descEn = "";
    serviceType.optionsTitleEn = "";
    serviceType.optionsTitleAr = "";
    serviceType.remarkAr = "";
    serviceType.remarkEn = "";
    serviceType.gauranteePeriodInDays = 30;
    serviceType.minRate = 50.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var mainService =
        PlumpMainService.instance.getMainService("المراحيض", "Toilets");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getPlumpServiceType3() {
    var serviceType = ServiceType();
    serviceType.nameAr = "أحواض الاستحمام";
    serviceType.nameEn = "Bathtubs";
    serviceType.descAr = "";
    serviceType.descEn = "";
    serviceType.optionsTitleEn = "";
    serviceType.optionsTitleAr = "";
    serviceType.remarkAr = "";
    serviceType.remarkEn = "";
    serviceType.gauranteePeriodInDays = 30;
    serviceType.minRate = 50.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var mainService =
        PlumpMainService.instance.getMainService("أحواض الاستحمام", "Bathtubs");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getPlumpServiceType4() {
    var serviceType = ServiceType();
    serviceType.nameAr = "المحابس والليات و الشطافات";
    serviceType.nameEn = "Valves, Hosepipes and Bidets";
    serviceType.descAr = "";
    serviceType.descEn = "";
    serviceType.optionsTitleEn = "";
    serviceType.optionsTitleAr = "";
    serviceType.remarkAr = "";
    serviceType.remarkEn = "";
    serviceType.gauranteePeriodInDays = 30;
    serviceType.minRate = 50.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var mainService = PlumpMainService.instance.getMainService(
        "المحابس والليات و الشطافات", "Valves, Hosepipes and Bidets");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getPlumpServiceType5() {
    var serviceType = ServiceType();
    serviceType.nameAr = "عوامات الخزانات";
    serviceType.nameEn = "Tank Buoys";
    serviceType.descAr = "";
    serviceType.descEn = "";
    serviceType.optionsTitleEn = "";
    serviceType.optionsTitleAr = "";
    serviceType.remarkAr = "";
    serviceType.remarkEn = "";
    serviceType.gauranteePeriodInDays = 30;
    serviceType.minRate = 50.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var mainService = PlumpMainService.instance
        .getMainService("عوامات الخزانات", "Tank Buoys");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getPlumpServiceType6() {
    var serviceType = ServiceType();
    serviceType.nameAr = "تأسيس سباكة";
    serviceType.nameEn = "Establish Plumbing";
    serviceType.descAr = "";
    serviceType.descEn = "";
    serviceType.optionsTitleEn = "";
    serviceType.optionsTitleAr = "";
    serviceType.remarkAr = "";
    serviceType.remarkEn = "";
    serviceType.gauranteePeriodInDays = 30;
    serviceType.minRate = 50.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var mainService = PlumpMainService.instance
        .getMainService("تأسيس سباكة", "Establish Plumbing");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getPlumpServiceType7() {
    var serviceType = ServiceType();
    serviceType.nameAr = "ارغب بزيارة الفني";
    serviceType.nameEn = "I would like to request technician visit";
    serviceType.descAr = "اذا كنت لا تعلم يتشخيص الاعطال";
    serviceType.descEn = "If you do not know about faults diagnosis";
    serviceType.optionsTitleEn = "";
    serviceType.optionsTitleAr = "";
    serviceType.remarkAr =
        "تكلفة خدمة تشخيص الاعطال ٥٠ ريال في حال رفض الخدمة بعد المعاينة";
    serviceType.remarkEn =
        "Faults diagnosis service cost 50 in case of reject of service after inspection";
    serviceType.gauranteePeriodInDays = 30;
    serviceType.minRate = 50.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var mainService = PlumpMainService.instance.getMainService(
        "ارغب بزيارة فني سباكه",
        "I would like to request plump technician visit");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getPlumpServiceType8() {
    var serviceType = ServiceType();
    serviceType.nameAr = "الكشف عن الاعطال مجاناً";
    serviceType.nameEn = "Free Faults Diagnose";
    serviceType.descAr = "وفر سعر الكشفية و تواصل مع خبيرنا الفني";
    serviceType.descEn =
        "Save the price of the diagnose and contact our expert technician";
    serviceType.hasMainService = false;
    serviceType.action = ServiceTypeAction.contactTechViaWhatsapp;

    return serviceType;
  }

  ServiceType _getPlumpServiceType9() {
    var serviceType = ServiceType();
    serviceType.nameAr = "التواصل لطلب الضمان";
    serviceType.nameEn = "Contact us to request guarantee";
    serviceType.descAr = "واجهتني مشكلة بعد انتهاء الفني من العمل";
    serviceType.descEn =
        "In case you face issue after technician finish the work";
    serviceType.hasMainService = false;
    serviceType.action = ServiceTypeAction.contactTechViaWhatsapp;

    return serviceType;
  }
}

class PlumpMainService {
  static PlumpMainService instance = PlumpMainService();

  MainService getMainService(String nameAr, String nameEn) {
    var mainService = MainService();
    mainService.nameAr = nameAr;
    mainService.nameEn = nameEn;
    mainService.type = PlumpType.noType;
    mainService.hasSub = false;
    mainService.price = 50.0;
    mainService.priceDescAr =
        "للكشفيه وفي حال الاتفاق يتم خصم المبلغ من قيمة الاعمال";
    mainService.priceDescEn =
        "For diagnose and in case of agreement, the amount will be deducted from the value of the works";

    return mainService;
  }
}
