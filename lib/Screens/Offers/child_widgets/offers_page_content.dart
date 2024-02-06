import 'package:export_support_customer/FirebaseResources/firebase_manager.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/offers_model.dart';
import 'package:export_support_customer/Screens/Offers/child_widgets/offers_page_content_body.dart';
import 'package:export_support_customer/Screens/Offers/child_widgets/offers_page_content_header.dart';
import 'package:export_support_customer/SharedWisget/loader.dart';
import 'package:export_support_customer/SharedWisget/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OffersPageContent extends StatefulWidget {
  @override
  _OffersPageContentState createState() => _OffersPageContentState();
}

class _OffersPageContentState extends State<OffersPageContent> {
  FirebaseManager? _firebaseManager;
  List<OffersModel> _offerList = [];
  bool _isLoading = false;
  @override
  void initState() {
    _firebaseManager = FirebaseManager();

    _isLoading = true;

    _getOffers();

    super.initState();
  }

  _getOffers() {
    try {
      _firebaseManager?.getOffers().then((onValue) {
        setState(() {
          _offerList = OffersModel.fromDocumentSnapshotList(
              offerDocDataList: onValue.docs);
          _isLoading = false;
        });
      }).catchError((onError) {
        _stopLoading();
        Alert()
            .requestFailwithMessage(context: context, message: onError.message);
      });
    } on PlatformException catch (e) {
      _stopLoading();
      Alert()
          .requestFailwithMessage(context: context, message: e.message ?? '');
    }
  }

  _stopLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context);

    return Container(
      child: Column(
        children: <Widget>[
          OffersListContentHeader(),
          Expanded(
              child: _isLoading
                  ? Center(
                      child: Loader(
                      color: Colors.grey,
                    ))
                  : _offerList.length == 0
                      ? NoData(
                          message: localizations
                              .translate(LocalizedKey.noDealsTitle))
                      : OffersListContentBody(offerList: _offerList))
        ],
      ),
    );
  }
}
