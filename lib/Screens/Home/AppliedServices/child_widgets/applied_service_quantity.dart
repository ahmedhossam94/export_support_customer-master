import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class AppliedServicesQuantity extends StatefulWidget {
  AppliedServicesQuantity(
      {Key? key, required this.onQuantityChange, this.qauntity = 1});

  final Function(int) onQuantityChange;
  final int qauntity;

  @override
  _AppliedServicesQuantityState createState() =>
      _AppliedServicesQuantityState();
}

class _AppliedServicesQuantityState extends State<AppliedServicesQuantity> {
  List<int> _qaunityList = [];
  int _qaunity = 0;

  @override
  void initState() {
    _qaunityList = List.generate(100, (i) => i + 1);
    _qaunity = widget.qauntity;
    super.initState();
  }

  _handleQauntityChange(int? value) {
    setState(() {
      _qaunity = value ?? 0;
    });
    widget.onQuantityChange(value ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Row(
      children: <Widget>[
        Text(
          localizations.translate(LocalizedKey.quantityTitle),
          style: TextStyle(fontSize: Screen.fontSize(size: 18)),
        ),
        Container(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColor.darkGray.withAlpha(40),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: DropdownButtonHideUnderline(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: DropdownButton(
              isDense: true,
              icon: Icon(Icons.keyboard_arrow_down),
              value: _qaunity,
              onChanged: _handleQauntityChange,
              items: _qaunityList
                  .map((q) => DropdownMenuItem(
                        child: Center(child: Text("$q")),
                        value: q,
                      ))
                  .toList(),
            ),
          )),
        )
      ],
    );
  }
}
