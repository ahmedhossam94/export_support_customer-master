import 'package:export_support_customer/BlocResources/submitted_order_bloc.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/common_use.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/discount.dart';
import 'package:flutter/material.dart';

class SummaryPageContentDiscount extends StatefulWidget {
  SummaryPageContentDiscount(
      {Key? key,
      required this.dicountCodeTextController,
      required this.onApplyDiscount})
      : super(key: key);

  final TextEditingController dicountCodeTextController;
  final Function(Discount) onApplyDiscount;

  @override
  _SummaryPageContentDiscountState createState() =>
      _SummaryPageContentDiscountState();
}

class _SummaryPageContentDiscountState
    extends State<SummaryPageContentDiscount> {
  bool _isButtonEnabled = false;
  TextEditingController? _controller;
  SubmittedOrderBloc? _submittedOrderBloc;
  AppLocalizations? _localizations;

  @override
  void initState() {
    _isButtonEnabled = true;
    _controller = widget.dicountCodeTextController;
    _submittedOrderBloc = SubmittedOrderBloc();
    super.initState();
  }

  _onApplyButtonTapped() async {
    String code = _controller!.text;
    Common.instance.removeFocus(context);

    if (code == null || code.isEmpty) {
      Alert().warning(
          context: context,
          message: _localizations!
              .translate(LocalizedKey.noDiscountCodeEnterAlertMessage),
          onPressed: () {
            Common.instance.dismiss(context);
          });
    } else {
      setState(() {
        _isButtonEnabled = false;
      });
      Discount discount = await _submittedOrderBloc!.getDiscountCode(code);
      setState(() {
        _isButtonEnabled = true;
      });

      if (discount == null) {
        Alert().warning(
            context: context,
            message: _localizations!
                .translate(LocalizedKey.errorDiscountCodeEnterAlertMessage),
            onPressed: () {
              Common.instance.dismiss(context);
            });
      } else {
        setState(() {
          _isButtonEnabled = false;
        });
        widget.onApplyDiscount(discount);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: Screen.fontSize(size: 18)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  isDense: true,
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: _localizations!
                      .translate(LocalizedKey.discountCodeHintTitle),
                ),
              ),
            ),
          ),
          Container(
            width: 16,
          ),
          Expanded(
            child: SizedBox(
              child: ElevatedButton(
                style: ButtonStyle(
                  textStyle: MaterialStatePropertyAll(
                      TextStyle(color: AppColor.darkRed)),
                  side: MaterialStatePropertyAll(
                      BorderSide(color: AppColor.darkRed)),
                ),
                child: Text(
                  _localizations!.translate(LocalizedKey.applyButtonTitle),
                  style: TextStyle(fontSize: Screen.fontSize(size: 18)),
                ),
                onPressed: _isButtonEnabled ? _onApplyButtonTapped : null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
