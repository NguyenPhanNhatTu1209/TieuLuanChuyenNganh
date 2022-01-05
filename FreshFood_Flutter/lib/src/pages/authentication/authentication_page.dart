import 'package:flutter/material.dart';
import 'package:freshfood/src/pages/authentication/pages/login_page.dart';
import 'package:freshfood/src/pages/authentication/pages/register_page.dart';
import 'package:freshfood/src/routes/app_pages.dart';

class AuthenticationPages extends StatefulWidget {
  final String title;
  final int tuNghia;
  AuthenticationPages({this.title, this.tuNghia});
  @override
  _AuthenticationPagesState createState() => _AuthenticationPagesState();
}

class _AuthenticationPagesState extends State<AuthenticationPages> {
  bool signIn = true;

  @override
  void initState() {
    super.initState();
  }

  switchScreen() {
    setState(() {
      signIn = !signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return signIn
        ? LoginPages(
            toggleView: switchScreen,
          )
        : SignupPage(
            toggleView: switchScreen,
          );
  }
}
