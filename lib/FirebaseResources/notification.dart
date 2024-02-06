import 'dart:io';

import 'package:export_support_customer/BlocResources/app_bloc.dart';
import 'package:export_support_customer/FirebaseResources/database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  FirebaseMessaging? _firebaseMessaging;
  AppBloc? _appBloc;

  void setUpFirebase(AppBloc appBloc) {
    // _firebaseMessaging = FirebaseMessaging();
    _appBloc = appBloc;
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    // if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging!.getToken().then((token) {
      _appBloc!.setFCMToken.add(token!);
      print("FCM: $token");
    });

    if (Database.isTestMode) {
      _firebaseMessaging!.subscribeToTopic("offerTest").then((_) {
        print("Successfully subscribe to \"offerTest\"");
      });
      _firebaseMessaging!.subscribeToTopic("userNotifyTest").then((_) {
        print("Successfully subscribe to \"userNotifyTest\"");
      });
    } else {
      _firebaseMessaging!.subscribeToTopic("offer").then((_) {
        print("Successfully subscribe to \"offer\"");
      });
      _firebaseMessaging!.subscribeToTopic("userNotify").then((_) {
        print("Successfully subscribe to \"userNotify\"");
      });
    }

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print('on message $message');
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print('on resume $message');
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print('on launch $message');
    //   },
    // );
  }

  // void iOS_Permission() {
  //   _firebaseMessaging.requestNotificationPermissions(
  //       IosNotificationSettings(sound: true, badge: true, alert: true));
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings) {
  //     print("Settings registered: $settings");
  //   });
  // }
}
