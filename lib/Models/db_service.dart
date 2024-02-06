import 'package:export_support_customer/Models/main_service_type.dart';
import 'package:export_support_customer/Models/service_type_action.dart';
import 'package:export_support_customer/Models/services_model.dart';

class DBService {
  ServiceCatagory _getACService() {
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
      _getACServiceType6()
    ];
    return serviceCategory;
  }

  ServiceType _getACServiceType1() {
    var serviceType = ServiceType();
    serviceType.nameAr = "تركيب مكيفات";
    serviceType.nameEn = "AC Units Installation";
    serviceType.descAr = "تركيب  وحدات التكييف الخارجية والداخلية";
    serviceType.descEn = "Installation of Internal and External AC Units";
    serviceType.optionsTitleEn = "Choose AC Type";
    serviceType.optionsTitleAr = "إختر نوع المكيف";
    serviceType.remarkAr =
        "تشمل هذه الخدمة تركيب الوحدات الداخلية و الخارجية التكييف";
    serviceType.remarkEn =
        "This service include installation of internal and external AC units";
    serviceType.gauranteePeriodInDays = 30;
    serviceType.minRate = 100.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    // ------------------------------------- //

    var mainService1 = MainService();
    mainService1.nameAr = "تركيب مكيف سبلت";
    mainService1.nameEn = "Split-Type AC Unit Installation";
    mainService1.type = ACType.splite;
    mainService1.hasSub = true;

    var subMainService1ForMainService1 = SubMainService();
    subMainService1ForMainService1.nameAr = "تركيب  جديد";
    subMainService1ForMainService1.nameEn = "New installation";
    subMainService1ForMainService1.price = 250.0;
    subMainService1ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService1ForMainService1.priceDescEn = "For one AC";

    var subMainService2ForMainService1 = SubMainService();
    subMainService2ForMainService1.nameAr = "نقل وتركيب خارج المنزل";
    subMainService2ForMainService1.nameEn =
        "Transfer and install outside house";
    subMainService2ForMainService1.price = 390.0;
    subMainService2ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService2ForMainService1.priceDescEn = "For one AC";

    var subMainService3ForMainService1 = SubMainService();
    subMainService3ForMainService1.nameAr = "نقل وتركيب داخل المنزل";
    subMainService3ForMainService1.nameEn = "Transfer and install inside house";
    subMainService3ForMainService1.price = 250.0;
    subMainService3ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService3ForMainService1.priceDescEn = "For one AC";

    var subMainService4ForMainService1 = SubMainService();
    subMainService4ForMainService1.nameAr = "فك مكيف";
    subMainService4ForMainService1.nameEn = "Dismantle AC";
    subMainService4ForMainService1.price = 120.0;
    subMainService4ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService4ForMainService1.priceDescEn = "For one AC";

    mainService1.subMainServiceList = [
      subMainService1ForMainService1,
      subMainService2ForMainService1,
      subMainService3ForMainService1,
      subMainService4ForMainService1
    ];

    // ------------------------------------- //

    var mainService2 = MainService();
    mainService2.nameAr = "تركيب مكيف شباك";
    mainService2.nameEn = "Cassette-Type AC Unit Installation";
    mainService2.type = ACType.cassette;
    mainService2.hasSub = true;

    var subMainService1ForMainService2 = SubMainService();
    subMainService1ForMainService2.nameAr = "تركيب  جديد";
    subMainService1ForMainService2.nameEn = "New installation";
    subMainService1ForMainService2.price = 100.0;
    subMainService1ForMainService2.priceDescAr = "للمكيف الواحد";
    subMainService1ForMainService2.priceDescEn = "For one AC";

    var subMainService2ForMainService2 = SubMainService();
    subMainService2ForMainService2.nameAr = "نقل وتركيب خارج المنزل";
    subMainService2ForMainService2.nameEn =
        "Transfer and install outside house";
    subMainService2ForMainService2.price = 200.0;
    subMainService2ForMainService2.priceDescAr = "للمكيف الواحد";
    subMainService2ForMainService2.priceDescEn = "For one AC";

    var subMainService3ForMainService2 = SubMainService();
    subMainService3ForMainService2.nameAr = "نقل وتركيب داخل المنزل";
    subMainService3ForMainService2.nameEn = "Transfer and install inside house";
    subMainService3ForMainService2.price = 100.0;
    subMainService3ForMainService2.priceDescAr = "للمكيف الواحد";
    subMainService3ForMainService2.priceDescEn = "For one AC";

    var subMainService4ForMainService2 = SubMainService();
    subMainService4ForMainService2.nameAr = "فك مكيف";
    subMainService4ForMainService2.nameEn = "Dismantle AC";
    subMainService4ForMainService2.price = 100.0;
    subMainService4ForMainService2.priceDescAr = "للمكيف الواحد";
    subMainService4ForMainService2.priceDescEn = "For one AC";

    mainService2.subMainServiceList = [
      subMainService1ForMainService2,
      subMainService2ForMainService2,
      subMainService3ForMainService2,
      subMainService4ForMainService2
    ];

    // ------------------------------------- //

    var mainService3 = MainService();
    mainService3.nameAr = "تركيب مكيف دولاب";
    mainService3.nameEn = "Package-Type AC Unit Installation";
    mainService3.type = ACType.package;
    mainService3.hasSub = true;

    var subMainService1ForMainService3 = SubMainService();
    subMainService1ForMainService3.nameAr = "تركيب  جديد";
    subMainService1ForMainService3.nameEn = "New installation";
    subMainService1ForMainService3.price = 330.0;
    subMainService1ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService1ForMainService3.priceDescEn = "For one AC";

    var subMainService2ForMainService3 = SubMainService();
    subMainService2ForMainService3.nameAr = "نقل وتركيب خارج المنزل";
    subMainService2ForMainService3.nameEn =
        "Transfer and install outside house";
    subMainService2ForMainService3.price = 450.0;
    subMainService2ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService2ForMainService3.priceDescEn = "For one AC";

    var subMainService3ForMainService3 = SubMainService();
    subMainService3ForMainService3.nameAr = "نقل وتركيب داخل المنزل";
    subMainService3ForMainService3.nameEn = "Transfer and install inside house";
    subMainService3ForMainService3.price = 330.0;
    subMainService3ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService3ForMainService3.priceDescEn = "For one AC";

    var subMainService4ForMainService3 = SubMainService();
    subMainService4ForMainService3.nameAr = "فك مكيف";
    subMainService4ForMainService3.nameEn = "Dismantle AC";
    subMainService4ForMainService3.price = 150.0;
    subMainService4ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService4ForMainService3.priceDescEn = "For one AC";

    mainService3.subMainServiceList = [
      subMainService1ForMainService3,
      subMainService2ForMainService3,
      subMainService3ForMainService3,
      subMainService4ForMainService3
    ];

    serviceType.mainServiceList = [mainService1, mainService2, mainService3];

    return serviceType;
  }

  ServiceType _getACServiceType2() {
    var serviceType = ServiceType();
    serviceType.nameAr = "تنظيف المكيفات";
    serviceType.nameEn = "AC Units Cleaning";
    serviceType.descAr = "نظيف وحدات التكييف الداخلية و الخارجية";
    serviceType.descEn = "Cleaning the Indoor & Outdoor AC Units";
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

    var mainService1 = MainService();
    mainService1.nameAr = "تنظيف مكيفات سبلت مع تنظيف مجرى المياه";
    mainService1.nameEn = "Split-Type AC Unit Cleaning";
    mainService1.type = ACType.splite;
    mainService1.hasSub = false;
    mainService1.price = 145.0;
    mainService1.priceDescAr = "للمكيف الواحد";
    mainService1.priceDescEn = "For one AC";

    var mainService2 = MainService();
    mainService2.nameAr = "تنظيف مكيف شباك";
    mainService2.nameEn = "Cassette-Type AC Unit Cleaning";
    mainService2.type = ACType.cassette;
    mainService2.hasSub = false;
    mainService2.price = 100.0;
    mainService2.priceDescAr = "للمكيف الواحد";
    mainService2.priceDescEn = "For one AC";

    var mainService3 = MainService();
    mainService3.nameAr = "تنظيف مكيفات دولاب";
    mainService3.nameEn = "Package-Type AC Unit Cleaning";
    mainService3.type = ACType.package;
    mainService3.hasSub = false;
    mainService3.price = 149.45;
    mainService3.priceDescAr = "للمكيف الواحد";
    mainService3.priceDescEn = "For one AC";

    serviceType.mainServiceList = [mainService1, mainService2, mainService3];
    return serviceType;
  }

  ServiceType _getACServiceType3() {
    var serviceType = ServiceType();
    serviceType.nameAr = "إصلاح الأعطال والصيانة";
    serviceType.nameEn = "AC Repairs";
    serviceType.descAr = "اصلاح الأعطال التكييف وتغير قطع الغيار";
    serviceType.descEn = "AC repairs and change parts";
    serviceType.optionsTitleEn = "Choose AC Type";
    serviceType.optionsTitleAr = "إختر نوع المكيف";
    serviceType.remarkAr = "الاسعار لاتشمل قطع الغيار";
    serviceType.remarkEn = "Prices do not include spare parts";
    serviceType.gauranteePeriodInDays = 14;
    serviceType.minRate = 100.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    // ------------------------------------- //
    var mainService1 = MainService();
    mainService1.nameAr = "باقة الصيانة الشاملة لوحدات التكييف نوع سبلت";
    mainService1.nameEn = "Split-Type AC Overall Maintenance Package";
    mainService1.type = ACType.splite;
    mainService1.hasSub = true;

    var subMainService1ForMainService1 = SubMainService();
    subMainService1ForMainService1.nameAr = "تغير كوبستر";
    subMainService1ForMainService1.nameEn = "Change Capester";
    subMainService1ForMainService1.price = 100.0;
    subMainService1ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService1ForMainService1.priceDescEn = "For one AC";

    var subMainService2ForMainService1 = SubMainService();
    subMainService2ForMainService1.nameAr = "إصلاح تهريب فريون";
    subMainService2ForMainService1.nameEn = "Gass Leaking Repair";
    subMainService2ForMainService1.price = 100.0;
    subMainService2ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService2ForMainService1.priceDescEn = "For one AC";

    var subMainService3ForMainService1 = SubMainService();
    subMainService3ForMainService1.nameAr = "تغير دينمو داخلي";
    subMainService3ForMainService1.nameEn = "Change Internal Dynamo";
    subMainService3ForMainService1.price = 150.0;
    subMainService3ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService3ForMainService1.priceDescEn = "For one AC";

    var subMainService4ForMainService1 = SubMainService();
    subMainService4ForMainService1.nameAr = "تغير كمبريسر";
    subMainService4ForMainService1.nameEn = "Change Compresspor";
    subMainService4ForMainService1.price = 280.0;
    subMainService4ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService4ForMainService1.priceDescEn = "For one AC";

    var subMainService5ForMainService1 = SubMainService();
    subMainService5ForMainService1.nameAr = "تغير دينمو خارجي";
    subMainService5ForMainService1.nameEn = "Change External Dynamo";
    subMainService5ForMainService1.price = 120.0;
    subMainService5ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService5ForMainService1.priceDescEn = "For one AC";

    var subMainService6ForMainService1 = SubMainService();
    subMainService6ForMainService1.nameAr = "تغيير لوحة الكترونية";
    subMainService6ForMainService1.nameEn = "Electrical Board Repair";
    subMainService6ForMainService1.price = 120.0;
    subMainService6ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService6ForMainService1.priceDescEn = "For one AC";

    var subMainService7ForMainService1 = SubMainService();
    subMainService7ForMainService1.nameAr = "تركيب كونتاكتر";
    subMainService7ForMainService1.nameEn = "Install or Change Contecter";
    subMainService7ForMainService1.price = 100.0;
    subMainService7ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService7ForMainService1.priceDescEn = "For one AC";

    var subMainService8ForMainService1 = SubMainService();
    subMainService8ForMainService1.nameAr = "تسريب المياه";
    subMainService8ForMainService1.nameEn = "Water Leaking";
    subMainService8ForMainService1.price = 120.0;
    subMainService8ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService8ForMainService1.priceDescEn = "For one AC";

    var subMainService9ForMainService1 = SubMainService();
    subMainService9ForMainService1.nameAr = "فك وتركيب مروحة داخلي";
    subMainService9ForMainService1.nameEn =
        "Dismantle and install internal Fan";
    subMainService9ForMainService1.price = 150.0;
    subMainService9ForMainService1.priceDescAr = "للمكيف الواحد";
    subMainService9ForMainService1.priceDescEn = "For one AC";

    mainService1.subMainServiceList = [
      subMainService1ForMainService1,
      subMainService2ForMainService1,
      subMainService3ForMainService1,
      subMainService4ForMainService1,
      subMainService5ForMainService1,
      subMainService6ForMainService1,
      subMainService7ForMainService1,
      subMainService8ForMainService1,
      subMainService9ForMainService1
    ];

    // ------------------------------------- //

    var mainService2 = MainService();
    mainService2.nameAr = "باقة الصيانة الشاملة لوحدات التكييف نوع شباك";
    mainService2.nameEn = "Cassette-Type AC Overall Maintenance Package";
    mainService2.type = ACType.cassette;
    mainService2.hasSub = true;

    var subMainService1ForMainService2 = SubMainService();
    subMainService1ForMainService2.nameAr = "اصلاح دينمو المكيف";
    subMainService1ForMainService2.nameEn = "Dynamo Air Condition Repair";
    subMainService1ForMainService2.price = 79.25;
    subMainService1ForMainService2.priceDescAr = "للمكيف الواحد";
    subMainService1ForMainService2.priceDescEn = "For one AC";

    var subMainService2ForMainService2 = SubMainService();
    subMainService2ForMainService2.nameAr = "تغير بلور او مروحة";
    subMainService2ForMainService2.nameEn = "Change Blower or Fan";
    subMainService2ForMainService2.price = 59.98;
    subMainService2ForMainService2.priceDescAr = "للمكيف الواحد";
    subMainService2ForMainService2.priceDescEn = "For one AC";

    var subMainService3ForMainService2 = SubMainService();
    subMainService3ForMainService2.nameAr = "تغير ثرموستات";
    subMainService3ForMainService2.nameEn = "Change Thermostat";
    subMainService3ForMainService2.price = 59.65;
    subMainService3ForMainService2.priceDescAr = "للمكيف الواحد";
    subMainService3ForMainService2.priceDescEn = "For one AC";

    var subMainService4ForMainService2 = SubMainService();
    subMainService4ForMainService2.nameAr = "تغير مكثف , كوبستر";
    subMainService4ForMainService2.nameEn = "Change Capester";
    subMainService4ForMainService2.price = 69.98;
    subMainService4ForMainService2.priceDescAr = "للمكيف الواحد";
    subMainService4ForMainService2.priceDescEn = "For one AC";

    var subMainService5ForMainService2 = SubMainService();
    subMainService5ForMainService2.nameAr = "تغير كمبريسر 18 و 24 وحدة";
    subMainService5ForMainService2.nameEn = "Change Compresspor 18, 24 unit";
    subMainService5ForMainService2.price = 100.0;
    subMainService5ForMainService2.priceDescAr = "للمكيف الواحد";
    subMainService5ForMainService2.priceDescEn = "For one AC";

    var subMainService6ForMainService2 = SubMainService();
    subMainService6ForMainService2.nameAr = "إصلاح تهريب فريون";
    subMainService6ForMainService2.nameEn = "Gass Leaking Repair";
    subMainService6ForMainService2.price = 123.25;
    subMainService6ForMainService2.priceDescAr = "للمكيف الواحد";
    subMainService6ForMainService2.priceDescEn = "For one AC";

    mainService2.subMainServiceList = [
      subMainService1ForMainService2,
      subMainService2ForMainService2,
      subMainService3ForMainService2,
      subMainService4ForMainService2,
      subMainService5ForMainService2,
      subMainService6ForMainService2
    ];

    // ------------------------------------- //

    var mainService3 = MainService();
    mainService3.nameAr = "باقة الصيانة الشاملة لوحدات التكييف نوع دولاب";
    mainService3.nameEn = "Package-Type AC Overall Maintenance Package";
    mainService3.type = ACType.package;
    mainService3.hasSub = true;

    var subMainService1ForMainService3 = SubMainService();
    subMainService1ForMainService3.nameAr = "تغير مكثف , كوبستر";
    subMainService1ForMainService3.nameEn = "Change Capester";
    subMainService1ForMainService3.price = 69.98;
    subMainService1ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService1ForMainService3.priceDescEn = "For one AC";

    var subMainService2ForMainService3 = SubMainService();
    subMainService2ForMainService3.nameAr = "إصلاح تهريب فريون";
    subMainService2ForMainService3.nameEn = "Fix Gass Leaking";
    subMainService2ForMainService3.price = 100.0;
    subMainService2ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService2ForMainService3.priceDescEn = "For one AC";

    var subMainService3ForMainService3 = SubMainService();
    subMainService3ForMainService3.nameAr = "تغير دينمو مكينة داخلي";
    subMainService3ForMainService3.nameEn = "Change Internal Dynamo";
    subMainService3ForMainService3.price = 145.65;
    subMainService3ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService3ForMainService3.priceDescEn = "For one AC";

    var subMainService4ForMainService3 = SubMainService();
    subMainService4ForMainService3.nameAr = "تغير كمبريسر 18 و 24 و 30 وحدة";
    subMainService4ForMainService3.nameEn =
        "Change Compresspor 18, 24, 30 unit";
    subMainService4ForMainService3.price = 149.25;
    subMainService4ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService4ForMainService3.priceDescEn = "For one AC";

    var subMainService5ForMainService3 = SubMainService();
    subMainService5ForMainService3.nameAr = "تغير دينمو مكينة خارجي";
    subMainService5ForMainService3.nameEn = "Change External Dynamo";
    subMainService5ForMainService3.price = 100.0;
    subMainService5ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService5ForMainService3.priceDescEn = "For one AC";

    var subMainService6ForMainService3 = SubMainService();
    subMainService6ForMainService3.nameAr = "اصلاح لوحة الكترونية";
    subMainService6ForMainService3.nameEn = "Fixing Electrical Board";
    subMainService6ForMainService3.price = 100.0;
    subMainService6ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService6ForMainService3.priceDescEn = "For one AC";

    var subMainService7ForMainService3 = SubMainService();
    subMainService7ForMainService3.nameAr = "تركيب وتغير كنكتر";
    subMainService7ForMainService3.nameEn = "Install or Change Contecter";
    subMainService7ForMainService3.price = 79.25;
    subMainService7ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService7ForMainService3.priceDescEn = "For one AC";

    var subMainService8ForMainService3 = SubMainService();
    subMainService8ForMainService3.nameAr = "تسريب المياه";
    subMainService8ForMainService3.nameEn = "Water Leaking";
    subMainService8ForMainService3.price = 59.45;
    subMainService8ForMainService3.priceDescAr = "للمكيف الواحد";
    subMainService8ForMainService3.priceDescEn = "For one AC";

    mainService3.subMainServiceList = [
      subMainService1ForMainService3,
      subMainService2ForMainService3,
      subMainService3ForMainService3,
      subMainService4ForMainService3,
      subMainService5ForMainService3,
      subMainService6ForMainService3,
      subMainService7ForMainService3,
      subMainService8ForMainService3
    ];
    // ------------------------------------- //

    serviceType.mainServiceList = [mainService1, mainService2, mainService3];
    return serviceType;
  }

  ServiceType _getACServiceType4() {
    var serviceType = ServiceType();
    serviceType.nameAr = "تعبئة الفريون";
    serviceType.nameEn = "Gas Refill";
    serviceType.descAr = "تعبئة الفريون لجميع انواع التكييف والتبريد";
    serviceType.descEn = "Gas refill for AC types and cooling machines";
    serviceType.optionsTitleEn = "Choose AC Type";
    serviceType.optionsTitleAr = "إختر نوع المكيف";
    serviceType.remarkAr = "الاسعار تشمل جميع انواع المكيفات";
    serviceType.remarkEn = "Prices include all AC types";
    serviceType.gauranteePeriodInDays = 14;
    serviceType.minRate = 100.0;
    serviceType.hasMainService = true;
    serviceType.action = ServiceTypeAction.showMainServices;

    // -------------------------------------- //
    var mainService1 = MainService();
    mainService1.nameAr = "تعبئة فريون تكييف سبلت";
    mainService1.nameEn = "Split-Type AC Gas Refill";
    mainService1.type = ACType.splite;
    mainService1.hasSub = true;

    var subMainService1ForMainService1 = SubMainService();
    subMainService1ForMainService1.nameAr = "تعبئة فريون امريكي  R22";
    subMainService1ForMainService1.nameEn = "American Gas Refill R22";
    subMainService1ForMainService1.price = 169.98;
    subMainService1ForMainService1.priceDescAr = "تعبئة كاملة";
    subMainService1ForMainService1.priceDescEn = "Complete Filling";

    var subMainService2ForMainService1 = SubMainService();
    subMainService2ForMainService1.nameAr = "تعبئة فريون امريكي  R22";
    subMainService2ForMainService1.nameEn = "American Gas Refill R22";
    subMainService2ForMainService1.price = 180.0;
    subMainService2ForMainService1.priceDescAr = "نصف تعبئة";
    subMainService2ForMainService1.priceDescEn = "Half Filling";

    var subMainService3ForMainService1 = SubMainService();
    subMainService3ForMainService1.nameAr = "تعبئة فريون امريكي R410";
    subMainService3ForMainService1.nameEn = "American Gas Refill R410";
    subMainService3ForMainService1.price = 250.0;
    subMainService3ForMainService1.priceDescAr = "تعبئة كاملة";
    subMainService3ForMainService1.priceDescEn = "Complete Filling";

    mainService1.subMainServiceList = [
      subMainService1ForMainService1,
      subMainService2ForMainService1,
      subMainService3ForMainService1
    ];

    // -------------------------------------- //

    var mainService2 = MainService();
    mainService2.nameAr = "تعبئة فريون تكييف شباك";
    mainService2.nameEn = "Cassette-Type AC Gas Refill";
    mainService2.type = ACType.cassette;
    mainService2.hasSub = true;

    var subMainService1ForMainService2 = SubMainService();
    subMainService1ForMainService2.nameAr = "تعبئة فريون امريكي  R22";
    subMainService1ForMainService2.nameEn = "American Gas Refill R22";
    subMainService1ForMainService2.price = 169.98;
    subMainService1ForMainService2.priceDescAr = "تعبئة كاملة";
    subMainService1ForMainService2.priceDescEn = "Complete Filling";

    var subMainService2ForMainService2 = SubMainService();
    subMainService2ForMainService2.nameAr = "تعبئة فريون امريكي  R22";
    subMainService2ForMainService2.nameEn = "American Gas Refill R22";
    subMainService2ForMainService2.price = 100.0;
    subMainService2ForMainService2.priceDescAr = "نصف تعبئة";
    subMainService2ForMainService2.priceDescEn = "Half Filling";

    var subMainService3ForMainService2 = SubMainService();
    subMainService3ForMainService2.nameAr = "تعبئة فريون امريكي R410";
    subMainService3ForMainService2.nameEn = "American Gas Refill R410";
    subMainService3ForMainService2.price = 234.99;
    subMainService3ForMainService2.priceDescAr = "تعبئة كاملة";
    subMainService3ForMainService2.priceDescEn = "Complete Filling";

    mainService2.subMainServiceList = [
      subMainService1ForMainService2,
      subMainService2ForMainService2,
      subMainService3ForMainService2
    ];

    // -------------------------------------- //

    var mainService3 = MainService();
    mainService3.nameAr = "تعبئة فريون تكييف دولاب";
    mainService3.nameEn = "Package-Type AC Gas Refill";
    mainService3.type = ACType.package;
    mainService3.hasSub = true;

    var subMainService1ForMainService3 = SubMainService();
    subMainService1ForMainService3.nameAr = "تعبئة فريون امريكي  R22";
    subMainService1ForMainService3.nameEn = "American Gas Refill R22";
    subMainService1ForMainService3.price = 169.98;
    subMainService1ForMainService3.priceDescAr = "تعبئة كاملة";
    subMainService1ForMainService3.priceDescEn = "Complete Filling";

    var subMainService2ForMainService3 = SubMainService();
    subMainService2ForMainService3.nameAr = "تعبئة فريون امريكي  R22";
    subMainService2ForMainService3.nameEn = "American Gas Refill R22";
    subMainService2ForMainService3.price = 100.0;
    subMainService2ForMainService3.priceDescAr = "نصف تعبئة";
    subMainService2ForMainService3.priceDescEn = "Half Filling";

    var subMainService3ForMainService3 = SubMainService();
    subMainService3ForMainService3.nameAr = "تعبئة فريون امريكي R410";
    subMainService3ForMainService3.nameEn = "American Gas Refill R410";
    subMainService3ForMainService3.price = 234.99;
    subMainService3ForMainService3.priceDescAr = "تعبئة كاملة";
    subMainService3ForMainService3.priceDescEn = "Complete Filling";

    mainService3.subMainServiceList = [
      subMainService1ForMainService3,
      subMainService2ForMainService3,
      subMainService3ForMainService3
    ];
    // -------------------------------------- //

    serviceType.mainServiceList = [mainService1, mainService2, mainService3];
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

    var mainService1 = MainService();
    mainService1.nameAr = "كشفية مكيفات سبلت";
    mainService1.nameEn = "Diagnose Split-Type AC";
    mainService1.type = ACType.splite;
    mainService1.hasSub = false;
    mainService1.price = 100.0;
    mainService1.priceDescAr =
        "للكشفيه وفي حال الاتفاق يتم خصم المبلغ من قيمة الاعمال";
    mainService1.priceDescEn =
        "For diagnose and in case of agreement, the amount will be deducted from the value of the works";

    var mainService2 = MainService();
    mainService2.nameAr = "كشفية مكيفات شباك";
    mainService2.nameEn = "Diagnose Cassette-Type AC";
    mainService2.type = ACType.cassette;
    mainService2.hasSub = false;
    mainService2.price = 100.0;
    mainService2.priceDescAr =
        "للكشفيه وفي حال الاتفاق يتم خصم المبلغ من قيمة الاعمال";
    mainService2.priceDescEn =
        "For diagnose and in case of agreement, the amount will be deducted from the value of the works";

    var mainService3 = MainService();
    mainService3.nameAr = "كشفية مكيفات دولاب";
    mainService3.nameEn = "Diagnose Package-Type AC";
    mainService3.type = ACType.package;
    mainService3.hasSub = false;
    mainService3.price = 100.0;
    mainService3.priceDescAr =
        "للكشفيه وفي حال الاتفاق يتم خصم المبلغ من قيمة الاعمال";
    mainService3.priceDescEn =
        "For diagnose and in case of agreement, the amount will be deducted from the value of the works";

    serviceType.mainServiceList = [mainService1, mainService2, mainService3];
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

  ServiceCatagory _getHomeApplaincesService() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "أجهزة منزلية";
    serviceCategory.nameEn = "Home Applainces";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }

  ServiceCatagory _getElecService() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "كهرباء";
    serviceCategory.nameEn = "Electricity";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }

  ServiceCatagory _getPlumpService() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "سباكة";
    serviceCategory.nameEn = "Plumbing";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }

  ServiceCatagory _getInstallService() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "تركيب";
    serviceCategory.nameEn = "Installation";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }

  ServiceCatagory _getSecurityService() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "انظمة الحماية";
    serviceCategory.nameEn = "Security Systems";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }

  ServiceCatagory _getPaintService() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "دهانات";
    serviceCategory.nameEn = "Paints";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }

  ServiceCatagory _getFloorService() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "ارضيات";
    serviceCategory.nameEn = "Floors";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }

  ServiceCatagory _getCleanService() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "تنظيف";
    serviceCategory.nameEn = "Cleaning";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }

  ServiceCatagory _getElevatorService() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "المصاعد";
    serviceCategory.nameEn = "Elevators";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }

  ServiceCatagory _getStoreService() {
    var serviceCategory = ServiceCatagory();
    serviceCategory.nameAr = "المتجر";
    serviceCategory.nameEn = "Online Store";
    serviceCategory.isActive = false;
    serviceCategory.serviceTypeList = [];
    return serviceCategory;
  }

  List<Map<String, dynamic>> _generateServiceMapList(
      List<ServiceCatagory> serviceObjectList) {
    List<Map<String, dynamic>> servicesMapList = [];
    String id = "";
    int counter = 1;

    if (serviceObjectList != null) {
      serviceObjectList.forEach((sc) {
        int orderCounter = counter != 11 ? counter + 1 : 1;
        id = "SERV" + (counter < 10 ? "0$counter" : "$counter");

        Map<String, dynamic> service = {
          "Order": orderCounter,
          "ID": id,
          "NameAr": sc.nameAr,
          "NameEn": sc.nameEn,
          "IsActive": sc.isActive,
          "Items": _generateServiceTypeMapList(id, sc.serviceTypeList ?? [])
        };

        servicesMapList.add(service);
        counter += 1;
      });
    }

    return servicesMapList;
  }

  List<Map<String, dynamic>> _generateServiceTypeMapList(
      String pranetId, List<ServiceType> serviceTypeObjectList) {
    List<Map<String, dynamic>> serviceTypeMapList = [];
    String id = "";
    int counter = 1;

    if (serviceTypeObjectList != null) {
      serviceTypeObjectList.forEach((st) {
        id = "$pranetId-" + (counter < 10 ? "0$counter" : "$counter");

        Map<String, dynamic> serviceType = {
          "ID": id,
          "NameAr": st.nameAr,
          "NameEn": st.nameEn,
          "DescAr": st.descAr,
          "DescEn": st.descEn,
          "RemarkAr": st.remarkAr,
          "RemarkEn": st.remarkEn,
          "OptionsTitleAr": st.optionsTitleAr,
          "OptionsTitleEn": st.optionsTitleEn,
          "GauranteePeriodInDays": st.gauranteePeriodInDays,
          "MinRate": st.minRate,
          "HasMainService": st.hasMainService,
          "Action": st.action,
          "items": _generateMainServiceMapList(id, st.mainServiceList ?? [])
        };

        serviceTypeMapList.add(serviceType);
        counter += 1;
      });
    }

    return serviceTypeMapList;
  }

  List<Map<String, dynamic>> _generateMainServiceMapList(
      String pranetId, List<MainService> mainServiceObjectList) {
    List<Map<String, dynamic>> mainServiceMapList = [];
    String id = "";
    int counter = 1;

    if (mainServiceObjectList != null) {
      mainServiceObjectList.forEach((ms) {
        id = "$pranetId-" + (counter < 10 ? "0$counter" : "$counter");

        Map<String, dynamic> mainService = {
          "ID": id,
          "NameAr": ms.nameAr,
          "NameEn": ms.nameEn,
          "Type": ms.type,
          "HasSub": ms.hasSub
        };

        if (ms.hasSub ?? false) {
          mainService["SubMainService"] =
              _generateSubMainServicesMapList(id, ms.subMainServiceList ?? []);
        } else {
          mainService["Price"] = ms.price;
          mainService["PriceDescAr"] = ms.priceDescAr;
          mainService["PriceDescEn"] = ms.priceDescEn;
        }

        mainServiceMapList.add(mainService);
        counter += 1;
      });
    }

    return mainServiceMapList;
  }

  List<Map<String, dynamic>> _generateSubMainServicesMapList(
      String pranetId, List<SubMainService> subMainServiceObjectList) {
    List<Map<String, dynamic>> subMainServiceMapList = [];
    String id = "";
    int counter = 1;

    if (subMainServiceObjectList != null) {
      subMainServiceObjectList.forEach((sms) {
        id = "$pranetId-" + (counter < 10 ? "0$counter" : "$counter");

        Map<String, dynamic> subMainService = {
          "ID": id,
          "NameAr": sms.nameAr,
          "NameEn": sms.nameEn,
          "Price": sms.price,
          "PriceDescAr": sms.priceDescAr,
          "PriceDescEn": sms.priceDescEn
        };

        subMainServiceMapList.add(subMainService);
        counter += 1;
      });
    }

    return subMainServiceMapList;
  }

  List<Map<String, dynamic>> generateServicesMap() {
    List<ServiceCatagory> servicesList = [
      _getACService(),
      _getHomeApplaincesService(),
      _getElecService(),
      _getPlumpService(),
      _getInstallService(),
      _getSecurityService(),
      _getPaintService(),
      _getFloorService(),
      _getCleanService(),
      _getElevatorService(),
      _getStoreService()
    ];

    return _generateServiceMapList(servicesList);
  }
}
