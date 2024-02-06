import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class CodeSendDelegate {
  void onAutoRetrieveVerify(AuthCredential authCredential);
  void onCodeSendError(String error);
  void onCodeSendSuccess(String verId, int forceCodeResend);
  void onAutoRetrieveTimeout(String verId);
}

abstract class CodeVerifyDelegate {
  void onCodeVerifySuccess(User user);
  void onCodeVerifyError(String error);
}

abstract class LocationDelegate {
  void getLocation(String address, LatLng coordinate);
}

abstract class OrderHistoryDelegate {
  void isReqiureUpdate(bool isReqiure);
}

abstract class AddNewServiceDelegate {
  void isAddedNewService();
}
