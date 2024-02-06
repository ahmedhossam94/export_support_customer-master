import 'package:export_support_customer/Models/ServiceData/Models/ac_condition.dart';
import 'package:export_support_customer/Models/ServiceData/Models/clean.dart';
import 'package:export_support_customer/Models/ServiceData/Models/electric.dart';
import 'package:export_support_customer/Models/ServiceData/Models/elevator.dart';
import 'package:export_support_customer/Models/ServiceData/Models/floor.dart';
import 'package:export_support_customer/Models/ServiceData/Models/home_applainces.dart';
import 'package:export_support_customer/Models/ServiceData/Models/installation.dart';
import 'package:export_support_customer/Models/ServiceData/Models/paint.dart';
import 'package:export_support_customer/Models/ServiceData/Models/plump.dart';
import 'package:export_support_customer/Models/ServiceData/Models/security.dart';
import 'package:export_support_customer/Models/ServiceData/Models/store.dart';
import 'package:export_support_customer/Models/services_model.dart';

class DBService {
  List<Map<String, dynamic>> _generateServiceMapList(
      List<ServiceCatagory>? serviceObjectList) {
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
      ACService.instance.genetate(),
      HomeApplaincesService.instance.generate(),
      ElectricService.instance.generate(),
      PlumpService.instance.generate(),
      InstallService.instance.generate(),
      SecurityService.instance.generate(),
      PaintService.instance.generate(),
      FloorService.instance.generate(),
      CleanService.instance.generate(),
      ElevatorService.instance.generate(),
      StoreService.instance.generate()
    ];

    return _generateServiceMapList(servicesList);
  }
}
