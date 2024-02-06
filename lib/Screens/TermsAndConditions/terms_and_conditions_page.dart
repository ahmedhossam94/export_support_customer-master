import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/BlocResources/base_provider.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/general_details.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  static const String route = "/TermsAndConditions";

  TermsAndConditionsPage({Key? key, this.isInNavigationStack = false})
      : super(key: key);

  final bool isInNavigationStack;

  Widget _comingFromMenuList() {
    return SafeArea(child: TermsAndConditionsPageContent());
  }

  Widget _comingInNavigationStack() {
    return ImageBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(),
        body: SafeArea(child: TermsAndConditionsPageContent()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isInNavigationStack
        ? _comingInNavigationStack()
        : _comingFromMenuList();
    // return ImageBackgroundContainer(
    //   child: isInNavigationStack ? _comingInNavigationStack() : _comingFromMenuList()
    // );
  }
}

class TermsAndConditionsPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TermsAndConditions> terms = BaseProvider.of<AppBloc>(context)
        .generalDetails
        .submitOrder
        .termsAndConditions;
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      child: Column(
        children: <Widget>[
          Text(
            localizations.translate(LocalizedKey.termsAndConditionsTitle),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Screen.fontSize(size: 28)),
          ),
          //Container(height: 16,),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                  itemCount: terms.length,
                  itemBuilder: (_, index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "\u{2022} ${localizations.isArabic() ? terms[index].textAr : terms[index].textEn}",
                          style: TextStyle(fontSize: Screen.fontSize(size: 18)),
                        ));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
