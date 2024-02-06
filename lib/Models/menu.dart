import 'package:export_support_customer/Models/enums.dart';
import 'package:flutter/material.dart';

class Menu {
  String name;
  MenuRouteType type;
  Menu({required this.name, required this.type});
}

class MenuContent {
  MenuRouteType type;
  Widget widget;
  MenuContent({required this.type, required this.widget});
}
