import 'package:export_support_customer/FirebaseResources/firebase_manager.dart';
import 'package:export_support_customer/HelperClass/alert.dart';
import 'package:export_support_customer/HelperClass/color.dart';
import 'package:export_support_customer/HelperClass/images_name.dart';
import 'package:export_support_customer/HelperClass/ui.dart';
import 'package:export_support_customer/Localization/app_localization.dart';
import 'package:export_support_customer/Localization/localized_key.dart';
import 'package:export_support_customer/Models/notification.dart';
import 'package:export_support_customer/SharedWisget/app_bar.dart';
import 'package:export_support_customer/SharedWisget/loader.dart';
import 'package:export_support_customer/SharedWisget/no_data.dart';
import 'package:export_support_customer/SharedWisget/scaffold_with_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationPage extends StatelessWidget {
  static const String route = "/NotificationPage";

  @override
  Widget build(BuildContext context) {
    return ImageBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(),
        body: SafeArea(child: NotificationPageContent()),
      ),
    );
  }
}

class NotificationPageContent extends StatefulWidget {
  @override
  _NotificationPageContentState createState() =>
      _NotificationPageContentState();
}

class _NotificationPageContentState extends State<NotificationPageContent> {
  FirebaseManager? _firebaseManager;
  AppLocalizations? _localizations;
  List<NotificationModel> _notificationList = [];
  bool _isLoading = false;

  @override
  void initState() {
    _notificationList = [];
    _firebaseManager = FirebaseManager();
    _isLoading = true;

    _getNotifications();

    super.initState();
  }

  _getNotifications() {
    try {
      _firebaseManager?.getNotification().then((onValue) {
        if (onValue != null) {
          setState(() {
            _notificationList = NotificationModel.fromDocumentSnapshotList(
                docList: onValue.docs);
            _isLoading = false;
          });
        } else {
          _stopLoading();
        }
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
    _localizations = AppLocalizations.of(context);
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              _localizations!.translate(LocalizedKey.notificationHeaderTitle),
              style: TextStyle(
                  fontSize: Screen.fontSize(size: 24), color: AppColor.darkRed),
            ),
          ),
          Container(
            height: 8,
          ),
          Expanded(
              child: _isLoading
                  ? Center(
                      child: Loader(
                      color: Colors.grey,
                    ))
                  : _notificationList.length == 0
                      ? NoData(
                          message: _localizations!
                              .translate(LocalizedKey.noNotificationTitle))
                      : NotificationListContent(
                          notificationList: _notificationList))
        ],
      ),
    );
  }
}

class NotificationListContent extends StatelessWidget {
  NotificationListContent({Key? key, required this.notificationList})
      : super(key: key);

  final List<NotificationModel> notificationList;

  @override
  Widget build(BuildContext context) {
    bool isArabic = AppLocalizations.of(context).isArabic();
    return Container(
      child: ListView.separated(
          itemBuilder: (_, index) => ListTile(
                leading: Image(
                  image: AssetImage(ImageName.tools),
                  height: Screen.screenWidth * 0.1,
                ),
                title: Text(
                  isArabic
                      ? notificationList[index].titleAr
                      : notificationList[index].titleEn,
                  style: TextStyle(fontSize: Screen.fontSize(size: 18)),
                ),
              ),
          separatorBuilder: (_, index) => Divider(
                height: 1,
                color: Colors.black,
              ),
          itemCount: notificationList.length),
    );
  }
}
