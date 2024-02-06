import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> getUser() async {
    User user = _auth.currentUser!;
    return user;
  }

  Future<void> sendVerifyCode(
      String phone,
      Function(AuthCredential) onAutoRetrieveVerify,
      Function(String) onError,
      Function(String, int) onSuccess,
      Function(String) onAutoRetrieveTimeout,
      {int? forceCodeResend}) {
    // When auto retrieve code is complete
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential authCredential) => onAutoRetrieveVerify(authCredential);
    // When Verification code is failed
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) => onError(exception.message ?? '');
    // When verification code is sent to user
    final PhoneCodeSent smsCodeSent = (String verId, [int? forceCodeResend]) =>
        onSuccess(verId, forceCodeResend!);
    // When auto retrieve code is failed
    final PhoneCodeAutoRetrievalTimeout autoRetrieveTimeout =
        (String verId) => onAutoRetrieveTimeout(verId);

    return _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 0),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieveTimeout);
  }

  Future<void> signIn(
      {required String verificationId,
      required String smsCode,
      required AuthCredential autoRetrieveAuthCredential,
      required Function(User) onSuccess,
      required Function(String) onError}) {
    AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    return _auth
        .signInWithCredential(autoRetrieveAuthCredential ?? credential)
        .then((user) {
      onSuccess(user.user!);
    }).catchError((error) {
      onError(error.message.toString());
    });
  }

  // Future<void> resendVerifyCode() {
  //   return _auth.re
  // }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
