import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freshfood/src/public/constant.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ManagerWalletPage extends StatefulWidget {
  int method;
  ManagerWalletPage({this.method});
  @override
  _ManagerWalletPageState createState() => _ManagerWalletPageState();
}

class _ManagerWalletPageState extends State<ManagerWalletPage> {
  // final _key = UniqueKey();
  WebViewController _controller;
  GetSnackBar getSnackBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản Lý Thanh Toán'),
      ),
      body: WebView(
        initialUrl: widget.method == 2
            ? "https://sandbox.vnpayment.vn/merchantv2/Users/Login.htm"
            : "https://www.sandbox.paypal.com/us/signin",
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
      ),
    );
  }
}
