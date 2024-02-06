import 'package:export_support_customer/Screens/SignIn/child_widgets/signIn/sign_in_form.dart';
import 'package:export_support_customer/Screens/SignIn/child_widgets/signIn/sign_in_header.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key, required this.onSignIn, required this.onRegister})
      : super(key: key);

  final Function() onSignIn;
  final Function() onRegister;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            SignInHeader(),
            SignInForm(
              onSignIn: onSignIn,
              onRegister: onRegister,
            )
          ],
        ),
      ),
    ));
  }
}
