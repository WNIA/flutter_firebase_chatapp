import 'package:flutter/material.dart';
import 'package:testing_app/ui/LoginPage.dart';
import 'package:testing_app/ui/SignUpPage.dart';

class Authenticate extends StatefulWidget {
  static final routeName ="/";
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginPage(toggleView);
    } else {
      return SignUpPage(toggleView);
    }
  }
}
