import 'dart:async';
import 'package:export_support_customer/HelperClass/delegates.dart';
import 'package:export_support_customer/HelperClass/validator.dart';
import 'package:export_support_customer/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:export_support_customer/FirebaseResources/firebase_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginBloc extends Validator {
  FirebaseManager _firebaseManager = FirebaseManager();
  final _phone = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _code = BehaviorSubject<String>();
  final _forceCodeResend = BehaviorSubject<int>();

  String phoneForDisplay = '';
  String? verificationID;
  UserModel? userInfo;

  final String phoneCode = "+966";

  Stream<String> get phone => _phone.stream.transform(validatePhone);
  Function(String) get phoneChange => _phone.sink.add;

  Stream<String> get name => _name.stream.transform(validateName);
  Function(String) get nameChange => _name.sink.add;

  Stream<String> get code => _code.stream.transform(validateCode);
  Function(String) get codeChange => _code.sink.add;

  Stream<int> get forceCodeResend => _forceCodeResend.stream;
  Function(int) get forceCodeResendChange => _forceCodeResend.sink.add;

  // -- Firebase Methods -- //

  Future<QuerySnapshot> get getServices => _firebaseManager.getServices();

  Future<bool> isUserExist() async {
    String phoneNumber = phoneCode + _phone.value;
    QuerySnapshot user =
        await _firebaseManager.getUserInfoByPhone(phone: phoneNumber);
    bool isExist = user.docs.isNotEmpty;

    if (isExist) {
      userInfo = UserModel.fromDocumentSnapshot(user.docs.first);
    }

    return isExist;
  }

  Future<void> sendVerificationCode(CodeSendDelegate delegate) {
    final formattedPhoneNumber = "+966" + _phone.value;
    final forceCode = _forceCodeResend == null ? null : _forceCodeResend.value;

    return _firebaseManager.sendVerifyCode(
        formattedPhoneNumber,
        delegate.onAutoRetrieveVerify,
        delegate.onCodeSendError,
        delegate.onCodeSendSuccess,
        delegate.onAutoRetrieveTimeout,
        forceCodeResend: forceCode);
  }

  Future<void> signIn(
      {AuthCredential? autoRetrieveAuthCredential,
      required CodeVerifyDelegate delegate,
      required bool isUserExist,
      required String lang}) {
    String? smsCode = _code == null ? null : _code.value;
    return _firebaseManager.signIn(
        verificationId: verificationID ?? '',
        smsCode: smsCode ?? '',
        autoRetrieveAuthCredential: autoRetrieveAuthCredential!,
        onSuccess: (user) {
          if (!isUserExist) {
            if ((_phone == null || _phone.value.isEmpty) &&
                (_name == null || _name.value.isEmpty)) {
              delegate.onCodeVerifyError(
                  "Could not complete registration. Please try again");
              return;
            }
            final formattedPhoneNumber = "+966" + _phone.value;
            userInfo = UserModel(
                id: user.uid,
                phone: formattedPhoneNumber,
                name: _name.value,
                preferredLand: lang,
                dateCreated: DateTime.now().toUtc().millisecondsSinceEpoch);
            register(userInfo!);
          }
          delegate.onCodeVerifySuccess(user);
        },
        onError: delegate.onCodeVerifyError);
  }

  Future<void> register(UserModel user) {
    return _firebaseManager.saveUserInfo(user);
  }

  // -- End Firebase Methods -- //

  dispose() {
    _phone.close();
    _name.close();
    _code.close();
    _forceCodeResend.close();
  }
}
