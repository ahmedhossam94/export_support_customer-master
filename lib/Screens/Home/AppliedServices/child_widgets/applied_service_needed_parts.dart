import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:flutter/material.dart';

class AppliedServicesCheckbox extends StatefulWidget {
  AppliedServicesCheckbox(
      {Key? key, required this.onChangeNeededParts, this.neededParts = false});

  final Function(bool) onChangeNeededParts;
  final bool neededParts;

  @override
  _AppliedServicesCheckboxState createState() =>
      _AppliedServicesCheckboxState();
}

class _AppliedServicesCheckboxState extends State<AppliedServicesCheckbox> {
  bool _neededPart = false;

  @override
  void initState() {
    _neededPart = widget.neededParts;
    super.initState();
  }

  _handleCheckboxChange(bool? value) {
    setState(() {
      _neededPart = value ?? false;
    });
    widget.onChangeNeededParts(_neededPart);
  }

  _handleCheckboxChangeOnTap() {
    setState(() => _neededPart = !_neededPart);
    widget.onChangeNeededParts(_neededPart);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Container(
              height: Screen.screenWidth * 0.1,
              width: Screen.screenWidth * 0.1,
              child: Checkbox(
                activeColor: AppColor.darkRed,
                value: _neededPart,
                onChanged: _handleCheckboxChange,
              ),
            ),
            Text(localizations.translate(LocalizedKey.neededPartTitle),
                style: TextStyle(fontSize: Screen.fontSize(size: 18)))
          ],
        ),
        onTap: _handleCheckboxChangeOnTap,
      ),
    );
  }
}
