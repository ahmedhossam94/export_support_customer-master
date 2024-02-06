import 'package:export_support_customer/Models/main_service_type.dart';
import 'package:export_support_customer/Models/service_type_action.dart';
import 'package:export_support_customer/Models/services_model.dart';

class ACService {
  static ACService instance = ACService();
  ServiceCatagory genetate() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "تكييف";
    serviceCategory.nameEn = "Air Condition";
    serviceCategory.isActive = true;
    serviceCategory.serviceTypeList = [
      _getACServiceType1(),
      _getACServiceType2(),
      _getACServiceType3(),
      _getACServiceType4(),
      _getACServiceType5(),
      _getACServiceType6(),
      _getACServiceType7()
    ];
    return serviceCategory;
  }

  ServiceType _getACServiceType1() {
    var serviceType = ServiceType();
    serviceType.nameAr = "فك و تركيب";
    serviceType.nameEn = "Dismantle and Installation";
    serviceType.descAr = "فك وتركيب الوحدات الداخلية والخارجية";
    serviceType.descEn =
        "Dismantle and installation of internal and external units";
    serviceType.optionsTitleEn = "Services";
    serviceType.optionsTitleAr = "الخدمات";
    serviceType.remarkAr =
        "تشمل هذه الخدمة فك و تركيب الوحدات الداخلية و الخارجية";
    serviceType.remarkEn =
        "This service include dismantle and installation of internal and external units";
    serviceType.gauranteePeriodInDays = 30;
    serviceType.minRate = 100.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var splite = ACSpliteMainService.instance.getDismantleAndInstallation();
    var cassette = ACCassetteMainService.instance.getDismantleAndInstallation();
    var package = ACPackageMainService.instance.getDismantleAndInstallation();
    var centralConcealed =
        ACCentralConcealedMainService.instance.getDismantleAndInstallation();
    var centralPackage =
        ACCentralPackgeMainService.instance.getDismantleAndInstallation();

    serviceType.mainServiceList = [
      splite,
      cassette,
      package,
      centralConcealed,
      centralPackage
    ];

    return serviceType;
  }

  ServiceType _getACServiceType2() {
    var serviceType = ServiceType();
    serviceType.nameAr = "غسيل و تنظيف";
    serviceType.nameEn = "Washing and Cleaning";
    serviceType.descAr = "تنظيف وتعقيم وحدات التكييف بمواد خاصة";
    serviceType.descEn =
        "Cleaning and sterilizing the AC units with special materials";
    serviceType.optionsTitleEn = "Choose AC Type";
    serviceType.optionsTitleAr = "إختر نوع المكيف";
    serviceType.remarkAr =
        "تشمل هذه الخدمة تنظيف وحدات التكييف الداخلية لأجهزة التكييف";
    serviceType.remarkEn =
        "This service include cleaning the indoor & outdoor AC units";
    serviceType.gauranteePeriodInDays = 14;
    serviceType.minRate = 100.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var splite = ACSpliteMainService.instance.getCleaning();
    var cassette = ACCassetteMainService.instance.getCleaning();
    var package = ACPackageMainService.instance.getCleaning();
    var centralConcealed = ACCentralConcealedMainService.instance.getCleaning();
    var centralPackage = ACCentralPackgeMainService.instance.getCleaning();

    serviceType.mainServiceList = [
      splite,
      cassette,
      package,
      centralConcealed,
      centralPackage
    ];
    return serviceType;
  }

  ServiceType _getACServiceType3() {
    var serviceType = ServiceType();
    serviceType.nameAr = "إصلاح الأعطال والصيانة";
    serviceType.nameEn = "AC Repairs";
    serviceType.descAr = "صيانة و تغيير قطع الغيار في موقع العمل";
    serviceType.descEn = "Maintenance and change parts on job site";
    serviceType.optionsTitleEn = "Choose AC Type";
    serviceType.optionsTitleAr = "إختر نوع المكيف";
    serviceType.remarkAr = "الاسعار لاتشمل قطع الغيار";
    serviceType.remarkEn = "Prices do not include spare parts";
    serviceType.gauranteePeriodInDays = 14;
    serviceType.minRate = 100.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var splite = ACSpliteMainService.instance.getRepairs();
    var cassette = ACCassetteMainService.instance.getRepairs();
    var package = ACPackageMainService.instance.getRepairs();
    var centralConcealed = ACCentralConcealedMainService.instance.getRepairs();
    var centralPackage = ACCentralPackgeMainService.instance.getRepairs();

    serviceType.mainServiceList = [
      splite,
      cassette,
      package,
      centralConcealed,
      centralPackage
    ];
    return serviceType;
  }

  ServiceType _getACServiceType4() {
    var serviceType = ServiceType();
    serviceType.nameAr = "تعبئة الفريون";
    serviceType.nameEn = "Gas Refill";
    serviceType.descAr = "تعبئة فريون من نوع امريكي فقط";
    serviceType.descEn = "American's gas refill only";
    serviceType.optionsTitleEn = "Choose AC Type";
    serviceType.optionsTitleAr = "إختر نوع المكيف";
    serviceType.remarkAr = "الاسعار تشمل جميع انواع المكيفات";
    serviceType.remarkEn = "Prices include all AC types";
    serviceType.gauranteePeriodInDays = 14;
    serviceType.minRate = 100.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var splite = ACSpliteMainService.instance.getGasRefill();
    var cassette = ACCassetteMainService.instance.getGasRefill();
    var package = ACPackageMainService.instance.getGasRefill();
    var centralConcealed =
        ACCentralConcealedMainService.instance.getGasRefill();
    var centralPackage = ACCentralPackgeMainService.instance.getGasRefill();

    serviceType.mainServiceList = [
      splite,
      cassette,
      package,
      centralConcealed,
      centralPackage
    ];
    return serviceType;
  }

  ServiceType _getACServiceType5() {
    var serviceType = ServiceType();
    serviceType.nameAr = "ارغب بزيارة الفني";
    serviceType.nameEn = "I would like to request technician visit";
    serviceType.descAr = "اذا كنت لا تعلم يتشخيص الاعطال";
    serviceType.descEn = "If you do not know about faults diagnosis";
    serviceType.optionsTitleEn = "Choose AC Type";
    serviceType.optionsTitleAr = "إختر نوع المكيف";
    serviceType.remarkAr =
        "تكلفة خدمة تشخيص الاعطال ١٠٠ ريال في حال رفض الخدمة بعد المعاينة";
    serviceType.remarkEn =
        "Faults diagnosis service cost 100 in case of reject of service after inspection";
    serviceType.gauranteePeriodInDays = 0;
    serviceType.minRate = 100.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    var splite = ACSpliteMainService.instance.getTechVisit();
    var cassette = ACCassetteMainService.instance.getTechVisit();
    var package = ACPackageMainService.instance.getTechVisit();
    var centralConcealed =
        ACCentralConcealedMainService.instance.getTechVisit();
    var centralPackage = ACCentralPackgeMainService.instance.getTechVisit();

    serviceType.mainServiceList = [
      splite,
      cassette,
      package,
      centralConcealed,
      centralPackage
    ];
    return serviceType;
  }

  ServiceType _getACServiceType6() {
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

  ServiceType _getACServiceType7() {
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

class ACSpliteMainService {
  static ACSpliteMainService instance = ACSpliteMainService();

  MainService getDismantleAndInstallation() {
    var mainService = MainService();
    mainService.nameAr = "فك وتركيب مكيف سيبلت";
    mainService.nameEn = "Split-Type AC Unit Dismantle and Installation";
    mainService.type = ACType.splite;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "فك مكيف";
    sub1.nameEn = "Dismantle AC";
    sub1.price = 150.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "تركيب  جديد";
    sub2.nameEn = "New installation";
    sub2.price = 350.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "فك ونقل وتركيب داخل المنزل";
    sub3.nameEn = "Dismantle and Transfer and install inside house";
    sub3.price = 430.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    // var sub4 = SubMainService();
    // sub4.nameAr = "نقل وتركيب خارج المنزل";
    // sub4.nameEn = "Transfer and install outside house";
    // sub4.price = 390.0;
    // sub4.priceDescAr = "";
    // sub4.priceDescEn = "";
    // mainService.subMainServiceList.add(sub4);

    mainService.subMainServiceList = [sub1, sub2, sub3];
    return mainService;
  }

  MainService getCleaning() {
    var mainService = MainService();
    mainService.nameAr = "تنظيف مكيف سيبلت";
    mainService.nameEn = "Split-Type AC Unit Cleaning";
    mainService.type = ACType.splite;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "غسيل الوحدة الداخلية والخارجة";
    sub1.nameEn = "Clean Internal and External AC Unit";
    sub1.price = 165.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    // var sub2 = SubMainService();
    // sub2.nameAr = "تنظيف مجرى المياة بمواد خاصة";
    // sub2.nameEn = "Clean the Waterway with Special Materials";
    // sub2.price = 165.0;
    // sub2.priceDescAr = "";
    // sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "غسيل الوحدة الداخلية";
    sub3.nameEn = "Clean Internal AC Unit";
    sub3.price = 130.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    var sub4 = SubMainService();
    sub4.nameAr = "غسيل الوحدة الخارجية";
    sub4.nameEn = "Clean External AC Unit";
    sub4.price = 65.0;
    sub4.priceDescAr = "";
    sub4.priceDescEn = "";

    var sub5 = SubMainService();
    sub5.nameAr = "مادة خاصة للتنظيف المكيف";
    sub5.nameEn = "Special Material for AC Cleaning";
    sub5.price = 25.0;
    sub5.priceDescAr = "";
    sub5.priceDescEn = "";

    mainService.subMainServiceList = [sub1, sub3, sub4, sub5];
    return mainService;
  }

  MainService getRepairs() {
    var mainService = MainService();
    mainService.nameAr = "تغيير واصلاح قطع الغيار سيبلت";
    mainService.nameEn = "Split-Type AC Parts Repair and Change";
    mainService.type = ACType.splite;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "تغيير وتركيب الافياش شامل الفيش";
    sub1.nameEn = "Changing and installing Plugs, Including Plugs";
    sub1.price = 145.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "تغيير كباسيتر شامل القطعة";
    sub2.nameEn = "Remove the Clogged Pipes";
    sub2.price = 185.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "إصلاح تسريب المياه";
    sub3.nameEn = "Change Capester, Including Parts";
    sub3.price = 150.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    var sub4 = SubMainService();
    sub4.nameAr = "لحام مواسير الفريون";
    sub4.nameEn = "Gas Pipe Welding";
    sub4.price = 120.0;
    sub4.priceDescAr = "";
    sub4.priceDescEn = "";

    var sub5 = SubMainService();
    sub5.nameAr = "تغيير المروحة الخارجية";
    sub5.nameEn = "Change External Fan";
    sub5.price = 250.0;
    sub5.priceDescAr = "";
    sub5.priceDescEn = "";

    var sub6 = SubMainService();
    sub6.nameAr = "تغيير دينمو خارجي";
    sub6.nameEn = "Change External Dynamo";
    sub6.price = 200.0;
    sub6.priceDescAr = "";
    sub6.priceDescEn = "";

    var sub7 = SubMainService();
    sub7.nameAr = "تغيير دينمو داخلي";
    sub7.nameEn = "Change Internal Dynamo";
    sub7.price = 250.0;
    sub7.priceDescAr = "";
    sub7.priceDescEn = "";

    var sub8 = SubMainService();
    sub8.nameAr = "تغيير كونتاكتر شامل القطعة";
    sub8.nameEn = "Change Contecter, Including Parts";
    sub8.price = 275.0;
    sub8.priceDescAr = "";
    sub8.priceDescEn = "";

    var sub9 = SubMainService();
    sub9.nameAr = "تغيير الكومبرسر شامل اللحام";
    sub9.nameEn = "Change Compresspor, Including Welding";
    sub9.price = 350.0;
    sub9.priceDescAr = "";
    sub9.priceDescEn = "";

    var sub10 = SubMainService();
    sub10.nameAr = "إصلاح تهريب الكومبريسر";
    sub10.nameEn = "Compresspor Leak Repair";
    sub10.price = 390.0;
    sub10.priceDescAr = "";
    sub10.priceDescEn = "";

    var sub11 = SubMainService();
    sub11.nameAr = "فك إصلاح وتركيب اللوحة الالكترونية";
    sub11.nameEn = "Electrical Board Dismantle, Repair and install";
    sub11.price = 495.0;
    sub11.priceDescAr = "";
    sub11.priceDescEn = "";

    var sub12 = SubMainService();
    sub12.nameAr = "فك واصلاح اللديتر شامل تعبئة فريون";
    sub12.nameEn = "Dismantle and Repair Rediter, Including Gas Refil";
    sub12.price = 650.0;
    sub12.priceDescAr = "";
    sub12.priceDescEn = "";

    mainService.subMainServiceList = [
      sub1,
      sub2,
      sub3,
      sub4,
      sub5,
      sub6,
      sub7,
      sub8,
      sub9,
      sub10,
      sub11,
      sub12
    ];
    return mainService;
  }

  MainService getGasRefill() {
    var mainService = MainService();
    mainService.nameAr = "تعبئة فريون سيبلت R22 و R410";
    mainService.nameEn = "Split-Type AC Gas Refill R22 and R410";
    mainService.type = ACType.splite;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "نصف التعبئة فريون R22";
    sub1.nameEn = "Gas Refill half filling R22";
    sub1.price = 160.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "كامل التعبئة فريون R22";
    sub2.nameEn = "Gas Refill full filling R22";
    sub2.price = 210.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "نصف التعبئة فريون R410";
    sub3.nameEn = "Gas Refill half filling R410";
    sub3.price = 180.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    var sub4 = SubMainService();
    sub4.nameAr = "كامل التعبئة فريون R410";
    sub4.nameEn = "Gas Refill full filling R410";
    sub4.price = 230.0;
    sub4.priceDescAr = "";
    sub4.priceDescEn = "";

    mainService.subMainServiceList = [sub1, sub2, sub3, sub4];
    return mainService;
  }

  MainService getTechVisit() {
    var mainService = MainService();
    mainService.nameAr = "كشفية مكيفات سيبلت";
    mainService.nameEn = "Diagnose Split-Type AC";
    mainService.type = ACType.splite;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr =
        "للكشفيه وفي حال الاتفاق يتم خصم المبلغ من قيمة الاعمال";
    mainService.priceDescEn =
        "For diagnose and in case of agreement, the amount will be deducted from the value of the works";

    return mainService;
  }
}

class ACCassetteMainService {
  static ACCassetteMainService instance = ACCassetteMainService();

  MainService getDismantleAndInstallation() {
    var mainService = MainService();
    mainService.nameAr = "فك وتركيب مكيف شباك";
    mainService.nameEn = "Cassette-Type AC Unit Dismantle and Installation";
    mainService.type = ACType.cassette;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "فك مكيف";
    sub1.nameEn = "Dismantle AC";
    sub1.price = 120.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "تركيب  جديد";
    sub2.nameEn = "New installation";
    sub2.price = 150.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "نقل وتركيب داخل المنزل";
    sub3.nameEn = "Transfer and install inside house";
    sub3.price = 200.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    // var sub4 = SubMainService();
    // sub4.nameAr = "نقل وتركيب خارج المنزل";
    // sub4.nameEn = "Transfer and install outside house";
    // sub4.price = 200.0;
    // sub4.priceDescAr = "";
    // sub4.priceDescEn = "";

    mainService.subMainServiceList = [sub1, sub2, sub3];
    return mainService;
  }

  MainService getCleaning() {
    var mainService = MainService();
    mainService.nameAr = "تنظيف مكيف شباك";
    mainService.nameEn = "Cassette-Type AC Unit Cleaning";
    mainService.type = ACType.cassette;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "غسيل وحدة التكيف";
    sub1.nameEn = "Clean AC Unit";
    sub1.price = 150.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    // var sub2 = SubMainService();
    // sub2.nameAr = "تنظيف مجرى المياة بمواد خاصة";
    // sub2.nameEn = "Clean the Waterway with Special Materials";
    // sub2.price = 165.0;
    // sub2.priceDescAr = "";
    // sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "مادة خاصة لتنظيف المكيفات";
    sub3.nameEn = "Special Material for AC Cleaning";
    sub3.price = 25.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    mainService.subMainServiceList = [sub1, sub3];
    return mainService;
  }

  MainService getRepairs() {
    var mainService = MainService();
    mainService.nameAr = "تغيير واصلاح قطع الغيار شباك";
    mainService.nameEn = "Cassette-Type AC Parts Repair and Change";
    mainService.type = ACType.cassette;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "تغيير وتركيب الافياش شامل الفيش";
    sub1.nameEn = "Changing and installing Plugs, Including Plugs";
    sub1.price = 145.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "تغيير كباسيتر شامل القطعة";
    sub2.nameEn = "Remove the Clogged Pipes";
    sub2.price = 185.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "إصلاح تسريب المياه";
    sub3.nameEn = "Change Capester, Including Parts";
    sub3.price = 150.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    var sub4 = SubMainService();
    sub4.nameAr = "لحام مواسير الفريون";
    sub4.nameEn = "Gas Pipe Welding";
    sub4.price = 120.0;
    sub4.priceDescAr = "";
    sub4.priceDescEn = "";

    var sub5 = SubMainService();
    sub5.nameAr = "تغيير المروحة الخارجية";
    sub5.nameEn = "Change External Fan";
    sub5.price = 200.0;
    sub5.priceDescAr = "";
    sub5.priceDescEn = "";

    var sub6 = SubMainService();
    sub6.nameAr = "تغيير دينمو خارجي";
    sub6.nameEn = "Change External Dynamo";
    sub6.price = 380.0;
    sub6.priceDescAr = "";
    sub6.priceDescEn = "";

    var sub7 = SubMainService();
    sub7.nameAr = "تغيير كونتاكتر شامل القطعة";
    sub7.nameEn = "Change Contecter, Including Parts";
    sub7.price = 250.0;
    sub7.priceDescAr = "";
    sub7.priceDescEn = "";

    var sub8 = SubMainService();
    sub8.nameAr = "تغيير الكومبرسر شامل اللحام";
    sub8.nameEn = "Change Compresspor, Including Welding";
    sub8.price = 350.0;
    sub8.priceDescAr = "";
    sub8.priceDescEn = "";

    var sub9 = SubMainService();
    sub9.nameAr = "إصلاح تهريب الكومبريسر";
    sub9.nameEn = "Compresspor Leak Repair";
    sub9.price = 390.0;
    sub9.priceDescAr = "";
    sub9.priceDescEn = "";

    var sub10 = SubMainService();
    sub10.nameAr = "فك واصلاح اللديتر شامل تعبئة فريون";
    sub10.nameEn = "Dismantle and Repair Rediter, Including Gas Refil";
    sub10.price = 450.0;
    sub10.priceDescAr = "";
    sub10.priceDescEn = "";

    mainService.subMainServiceList = [
      sub1,
      sub2,
      sub3,
      sub4,
      sub5,
      sub6,
      sub7,
      sub8,
      sub9,
      sub10
    ];
    return mainService;
  }

  MainService getGasRefill() {
    var mainService = MainService();
    mainService.nameAr = "تعبئة فريون شباك R22 و R410";
    mainService.nameEn = "Cassette-Type AC Gas Refill R22 and R410";
    mainService.type = ACType.cassette;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "نصف التعبئة فريون R22";
    sub1.nameEn = "Gas Refill half filling R22";
    sub1.price = 160.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "كامل التعبئة فريون R22";
    sub2.nameEn = "Gas Refill full filling R22";
    sub2.price = 210.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "نصف التعبئة فريون R410";
    sub3.nameEn = "Gas Refill half filling R410";
    sub3.price = 180.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    var sub4 = SubMainService();
    sub4.nameAr = "نصف التعبئة فريون R410";
    sub4.nameEn = "Gas Refill full filling R410";
    sub4.price = 230.0;
    sub4.priceDescAr = "";
    sub4.priceDescEn = "";

    mainService.subMainServiceList = [sub1, sub2, sub3, sub4];
    return mainService;
  }

  MainService getTechVisit() {
    var mainService = MainService();
    mainService.nameAr = "كشفية مكيفات شباك";
    mainService.nameEn = "Diagnose Cassette-Type AC";
    mainService.type = ACType.cassette;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr =
        "للكشفيه وفي حال الاتفاق يتم خصم المبلغ من قيمة الاعمال";
    mainService.priceDescEn =
        "For diagnose and in case of agreement, the amount will be deducted from the value of the works";

    return mainService;
  }
}

class ACPackageMainService {
  static ACPackageMainService instance = ACPackageMainService();

  MainService getDismantleAndInstallation() {
    var mainService = MainService();
    mainService.nameAr = "فك وتركيب مكيف دولاب";
    mainService.nameEn = "Package-Type AC Unit Dismantle and Installation";
    mainService.type = ACType.package;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "فك مكيف";
    sub1.nameEn = "Dismantle AC";
    sub1.price = 250.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "تركيب  جديد";
    sub2.nameEn = "New installation";
    sub2.price = 450.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "نقل وتركيب داخل المنزل";
    sub3.nameEn = "Transfer and install inside house";
    sub3.price = 550.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    // var sub4 = SubMainService();
    // sub4.nameAr = "نقل وتركيب خارج المنزل";
    // sub4.nameEn = "Transfer and install outside house";
    // sub4.price = 450.0;
    // sub4.priceDescAr = "";
    // sub4.priceDescEn = "";

    mainService.subMainServiceList = [sub1, sub2, sub3];
    return mainService;
  }

  MainService getCleaning() {
    var mainService = MainService();
    mainService.nameAr = "تنظيف مكيفات دولاب";
    mainService.nameEn = "Package-Type AC Unit Cleaning";
    mainService.type = ACType.package;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "غسيل الوحدة الداخلية والخارجة";
    sub1.nameEn = "Clean Internal and External AC Unit";
    sub1.price = 250.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    // var sub2 = SubMainService();
    // sub2.nameAr = "تنظيف مجرى المياة بمواد خاصة";
    // sub2.nameEn = "Clean the Waterway with Special Materials";
    // sub2.price = 200.0;
    // sub2.priceDescAr = "";
    // sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "غسيل الوحدة الداخلية";
    sub3.nameEn = "Clean Internal AC Unit";
    sub3.price = 175.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    var sub4 = SubMainService();
    sub4.nameAr = "غسيل الوحدة الخارجية";
    sub4.nameEn = "Clean External AC Unit";
    sub4.price = 100.0;
    sub4.priceDescAr = "";
    sub4.priceDescEn = "";

    var sub5 = SubMainService();
    sub5.nameAr = "مادة خاصة للتنظيف المكيفات";
    sub5.nameEn = "Special Material for AC Cleaning";
    sub5.price = 30.0;
    sub5.priceDescAr = "";
    sub5.priceDescEn = "";

    mainService.subMainServiceList = [sub1, sub3, sub4, sub5];

    return mainService;
  }

  MainService getRepairs() {
    var mainService = MainService();
    mainService.nameAr = "تغيير واصلاح قطع الغيار دولاب";
    mainService.nameEn = "Package-Type AC Parts Repair and Change";
    mainService.type = ACType.package;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "تغيير وتركيب الافياش شامل الفيش";
    sub1.nameEn = "Changing and installing Plugs, Including Plugs";
    sub1.price = 145.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "تغيير كباسيتر شامل القطعة";
    sub2.nameEn = "Remove the Clogged Pipes";
    sub2.price = 185.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "إصلاح تسريب المياه";
    sub3.nameEn = "Change Capester, Including Parts";
    sub3.price = 165.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    var sub4 = SubMainService();
    sub4.nameAr = "لحام مواسير الفريون";
    sub4.nameEn = "Gas Pipe Welding";
    sub4.price = 120.0;
    sub4.priceDescAr = "";
    sub4.priceDescEn = "";

    var sub5 = SubMainService();
    sub5.nameAr = "تغيير المروحة الخارجية";
    sub5.nameEn = "Change External Fan";
    sub5.price = 350.0;
    sub5.priceDescAr = "";
    sub5.priceDescEn = "";

    var sub6 = SubMainService();
    sub6.nameAr = "تغيير دينمو خارجي";
    sub6.nameEn = "Change External Dynamo";
    sub6.price = 350.0;
    sub6.priceDescAr = "";
    sub6.priceDescEn = "";

    var sub7 = SubMainService();
    sub7.nameAr = "تغيير دينمو داخلي";
    sub7.nameEn = "Change Internal Dynamo";
    sub7.price = 450.0;
    sub7.priceDescAr = "";
    sub7.priceDescEn = "";

    var sub8 = SubMainService();
    sub8.nameAr = "تغيير كونتاكتر شامل القطعة";
    sub8.nameEn = "Change Contecter, Including Parts";
    sub8.price = 250.0;
    sub8.priceDescAr = "";
    sub8.priceDescEn = "";

    var sub9 = SubMainService();
    sub9.nameAr = "تغيير الكومبرسر شامل اللحام";
    sub9.nameEn = "Change Compresspor, Including Welding";
    sub9.price = 350.0;
    sub9.priceDescAr = "";
    sub9.priceDescEn = "";

    var sub10 = SubMainService();
    sub10.nameAr = "إصلاح تهريب الكومبريسر";
    sub10.nameEn = "Compresspor Leak Repair";
    sub10.price = 390.0;
    sub10.priceDescAr = "";
    sub10.priceDescEn = "";

    var sub11 = SubMainService();
    sub11.nameAr = "فك إصلاح وتركيب اللوحة الالكترونية";
    sub11.nameEn = "Electrical Board Dismantle, Repair and install";
    sub11.price = 595.0;
    sub11.priceDescAr = "";
    sub11.priceDescEn = "";

    var sub12 = SubMainService();
    sub12.nameAr = "فك واصلاح اللديتر شامل تعبئة فريون";
    sub12.nameEn = "Dismantle and Repair Rediter, Including Gas Refil";
    sub12.price = 750.0;
    sub12.priceDescAr = "";
    sub12.priceDescEn = "";

    mainService.subMainServiceList = [
      sub1,
      sub2,
      sub3,
      sub4,
      sub5,
      sub6,
      sub7,
      sub8,
      sub9,
      sub10,
      sub11,
      sub12
    ];
    return mainService;
  }

  MainService getGasRefill() {
    var mainService = MainService();
    mainService.nameAr = "تعبئة فريون دولاب R22 و R410";
    mainService.nameEn = "Package-Type AC Gas Refill R22 and R410";
    mainService.type = ACType.package;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "نصف التعبئة فريون R22";
    sub1.nameEn = "Gas Refill half filling R22";
    sub1.price = 180.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "كامل التعبئة فريون R22";
    sub2.nameEn = "Gas Refill full filling R22";
    sub2.price = 250.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "نصف التعبئة فريون R410";
    sub3.nameEn = "Gas Refill half filling R410";
    sub3.price = 200.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    var sub4 = SubMainService();
    sub4.nameAr = "كامل التعبئة فريون R410";
    sub4.nameEn = "Gas Refill full filling R410";
    sub4.price = 270.0;
    sub4.priceDescAr = "";
    sub4.priceDescEn = "";

    mainService.subMainServiceList = [sub1, sub2, sub3, sub4];
    return mainService;
  }

  MainService getTechVisit() {
    var mainService = MainService();
    mainService.nameAr = "كشفية مكيفات دولاب";
    mainService.nameEn = "Diagnose Package-Type AC";
    mainService.type = ACType.package;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr =
        "للكشفيه وفي حال الاتفاق يتم خصم المبلغ من قيمة الاعمال";
    mainService.priceDescEn =
        "For diagnose and in case of agreement, the amount will be deducted from the value of the works";

    return mainService;
  }
}

class ACCentralConcealedMainService {
  static ACCentralConcealedMainService instance =
      ACCentralConcealedMainService();

  MainService getDismantleAndInstallation() {
    var mainService = MainService();
    mainService.nameAr = "فك وتركيب مكيف مركزي - كونسيلد";
    mainService.nameEn = "Central AC - Concealed Dismantle and Installation";
    mainService.type = ACType.centralConcealed;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr = "للكشفيه - سوف يتم تحديد التسعيرة عند الزيارة";
    mainService.priceDescEn =
        "For diagnose - price will be determined upon visit";
    return mainService;
  }

  MainService getCleaning() {
    var mainService = MainService();
    mainService.nameAr = "تنظيف مكيفات مركزي - كونسيلد";
    mainService.nameEn = "Central AC - Concealed Cleaning";
    mainService.type = ACType.centralConcealed;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "غسيل الوحدة الداخلية والخارجة";
    sub1.nameEn = "Clean Internal and External AC Unit";
    sub1.price = 200.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "غسيل الوحدة الداخلية";
    sub2.nameEn = "Clean Internal AC Unit";
    sub2.price = 150.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "غسيل الوحدة الخارجية";
    sub3.nameEn = "Clean External AC Unit";
    sub3.price = 100.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    var sub4 = SubMainService();
    sub4.nameAr = "مادة خاصة للتنظيف المكيفات";
    sub4.nameEn = "Special Material for AC Cleaning";
    sub4.price = 25.0;
    sub4.priceDescAr = "";
    sub4.priceDescEn = "";

    mainService.subMainServiceList = [sub1, sub2, sub3, sub4];
    return mainService;
  }

  MainService getRepairs() {
    var mainService = MainService();
    mainService.nameAr = "تغيير واصلاح قطع الغيار مركزي - كونسيلد";
    mainService.nameEn = "Central AC - Concealed Parts Repair and Change";
    mainService.type = ACType.centralConcealed;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr = "للكشفيه - سوف يتم تحديد التسعيرة عند الزيارة";
    mainService.priceDescEn =
        "For diagnose - price will be determined upon visit";
    return mainService;
  }

  MainService getGasRefill() {
    var mainService = MainService();
    mainService.nameAr = "تعبئة فريون مركزي - كونسيلد R22 و R410";
    mainService.nameEn = "Central AC - Concealed Gas Refill R22 and R410";
    mainService.type = ACType.centralConcealed;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr = "للكشفيه - سوف يتم تحديد التسعيرة عند الزيارة";
    mainService.priceDescEn =
        "For diagnose - price will be determined upon visit";
    return mainService;
  }

  MainService getTechVisit() {
    var mainService = MainService();
    mainService.nameAr = "كشفية مكيفات مركزي - كونسيلد";
    mainService.nameEn = "Diagnose Central AC - Concealed";
    mainService.type = ACType.centralConcealed;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr =
        "للكشفيه وفي حال الاتفاق يتم خصم المبلغ من قيمة الاعمال";
    mainService.priceDescEn =
        "For diagnose and in case of agreement, the amount will be deducted from the value of the works";
    return mainService;
  }
}

class ACCentralPackgeMainService {
  static ACCentralPackgeMainService instance = ACCentralPackgeMainService();

  MainService getDismantleAndInstallation() {
    var mainService = MainService();
    mainService.nameAr = "فك وتركيب مكيف مركزي - بكج";
    mainService.nameEn = "Central AC - Package Dismantle and Installation";
    mainService.type = ACType.centralPackage;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr = "للكشفيه - سوف يتم تحديد التسعيرة عند الزيارة";
    mainService.priceDescEn =
        "For diagnose - price will be determined upon visit";
    return mainService;
  }

  MainService getCleaning() {
    var mainService = MainService();
    mainService.nameAr = "تنظيف مكيفات مركزي - بكج";
    mainService.nameEn = "Central AC - Package Cleaning";
    mainService.type = ACType.centralPackage;
    mainService.hasSub = true;

    var sub1 = SubMainService();
    sub1.nameAr = "غسيل الوحدة الداخلية والخارجة";
    sub1.nameEn = "Clean Internal and External AC Unit";
    sub1.price = 250.0;
    sub1.priceDescAr = "";
    sub1.priceDescEn = "";

    var sub2 = SubMainService();
    sub2.nameAr = "غسيل الوحدة الداخلية";
    sub2.nameEn = "Clean Internal AC Unit";
    sub2.price = 180.0;
    sub2.priceDescAr = "";
    sub2.priceDescEn = "";

    var sub3 = SubMainService();
    sub3.nameAr = "غسيل الوحدة الخارجية";
    sub3.nameEn = "Clean External AC Unit";
    sub3.price = 120.0;
    sub3.priceDescAr = "";
    sub3.priceDescEn = "";

    var sub4 = SubMainService();
    sub4.nameAr = "مادة خاصة للتنظيف المكيفات";
    sub4.nameEn = "Special Material for AC Cleaning";
    sub4.price = 25.0;
    sub4.priceDescAr = "";
    sub4.priceDescEn = "";

    mainService.subMainServiceList = [sub1, sub2, sub3, sub4];
    return mainService;
  }

  MainService getRepairs() {
    var mainService = MainService();
    mainService.nameAr = "تغيير واصلاح قطع الغيار مركزي - بكج";
    mainService.nameEn = "Central AC - Package Parts Repair and Change";
    mainService.type = ACType.centralPackage;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr = "للكشفيه - سوف يتم تحديد التسعيرة عند الزيارة";
    mainService.priceDescEn =
        "For diagnose - price will be determined upon visit";
    return mainService;
  }

  MainService getGasRefill() {
    var mainService = MainService();
    mainService.nameAr = "تعبئة فريون مركزي - بكج R22 و R410";
    mainService.nameEn = "Central AC - Package Gas Refill R22 and R410";
    mainService.type = ACType.centralPackage;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr = "للكشفيه - سوف يتم تحديد التسعيرة عند الزيارة";
    mainService.priceDescEn =
        "For diagnose - price will be determined upon visit";
    return mainService;
  }

  MainService getTechVisit() {
    var mainService = MainService();
    mainService.nameAr = "كشفية مكيفات مركزي - بكج";
    mainService.nameEn = "Diagnose Central AC - Package";
    mainService.type = ACType.centralPackage;
    mainService.hasSub = false;
    mainService.price = 100.0;
    mainService.priceDescAr =
        "للكشفيه وفي حال الاتفاق يتم خصم المبلغ من قيمة الاعمال";
    mainService.priceDescEn =
        "For diagnose and in case of agreement, the amount will be deducted from the value of the works";
    return mainService;
  }
}
