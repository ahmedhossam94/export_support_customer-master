import 'package:export_support_customer/Models/service_type_action.dart';
import 'package:export_support_customer/Models/services_model.dart';
import 'package:export_support_customer/Models/main_service_type.dart';

class ElectricService {
  static ElectricService instance = ElectricService();
  ServiceCatagory generate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "كهرباء";
    serviceCategory.nameEn = "Electricity";
    serviceCategory.isActive = true;
    serviceCategory.serviceTypeList = [
      _getElectricServiceType1(),
      _getElectricServiceType2(),
      _getElectricServiceType3(),
      _getElectricServiceType4(),
      _getElectricServiceType5(),
      _getElectricServiceType6(),
      _getElectricServiceType7(),
      _getElectricServiceType8(),
      _getElectricServiceType9(),
      _getElectricServiceType10(),
      _getElectricServiceType11()
    ];
    return serviceCategory;
  }

  ServiceType _getElectricServiceType1() {
    var serviceType = ServiceType();
    serviceType.nameAr = "الإنارة الداخلية";
    serviceType.nameEn = "Interior Lighting";
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

    var mainService = ElectricMainService.instance
        .getMainService("الإنارة الداخلية", "Interior Lighting");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getElectricServiceType2() {
    var serviceType = ServiceType();
    serviceType.nameAr = "الإنارة الخارجية";
    serviceType.nameEn = "External Lighting";
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

    var mainService = ElectricMainService.instance
        .getMainService("الإنارة الخارجية", "External Lighting");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getElectricServiceType3() {
    var serviceType = ServiceType();
    serviceType.nameAr = "ثريا";
    serviceType.nameEn = "Chandelier";
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
        ElectricMainService.instance.getMainService("ثريا", "Chandelier");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getElectricServiceType4() {
    var serviceType = ServiceType();
    serviceType.nameAr = "تحويل انارة الى لد";
    serviceType.nameEn = "Turning the lights into LED";
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

    var mainService = ElectricMainService.instance
        .getMainService("تحويل انارة الى لد", "Turning the lights into LED");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getElectricServiceType5() {
    var serviceType = ServiceType();
    serviceType.nameAr = "مفاتيح وأفياش";
    serviceType.nameEn = "Switchers and Plugs";
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

    var mainService = ElectricMainService.instance
        .getMainService("مفاتيح وأفياش", "Switchers and Plugs");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getElectricServiceType6() {
    var serviceType = ServiceType();
    serviceType.nameAr = "مراوح الشفط والتهوية";
    serviceType.nameEn = "Ventilation Fans";
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

    var mainService = ElectricMainService.instance
        .getMainService("مراوح الشفط والتهوية", "Ventilation Fans");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getElectricServiceType7() {
    var serviceType = ServiceType();
    serviceType.nameAr = "ألواح توزيع الكهرباء";
    serviceType.nameEn = "";
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

    var mainService = ElectricMainService.instance.getMainService(
        "ألواح توزيع الكهرباء", "Electricity Distribution Panels");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getElectricServiceType8() {
    var serviceType = ServiceType();
    serviceType.nameAr = "تأسيس كهرباء";
    serviceType.nameEn = "Establish Electricity";
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

    var mainService = ElectricMainService.instance
        .getMainService("تأسيس كهرباء", "Establish Electricity");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getElectricServiceType9() {
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

    var mainService = ElectricMainService.instance.getMainService(
        "ارغب بزيارة فني كهرباء",
        "I would like to request electric technician visit");

    serviceType.mainServiceList = [mainService];

    return serviceType;
  }

  ServiceType _getElectricServiceType10() {
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

  ServiceType _getElectricServiceType11() {
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

class ElectricMainService {
  static ElectricMainService instance = ElectricMainService();

  MainService getMainService(String nameAr, String nameEn) {
    var mainService = MainService();
    mainService.nameAr = nameAr;
    mainService.nameEn = nameEn;
    mainService.type = ElectricType.noType;
    mainService.hasSub = false;
    mainService.price = 50.0;
    mainService.priceDescAr =
        "للكشفيه وفي حال الاتفاق يتم خصم المبلغ من قيمة الاعمال";
    mainService.priceDescEn =
        "For diagnose and in case of agreement, the amount will be deducted from the value of the works";

    return mainService;
  }
}
