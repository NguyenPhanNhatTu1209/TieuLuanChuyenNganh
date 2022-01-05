import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freshfood/src/public/constant.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebPage extends StatefulWidget {
  final String link;
  PaymentWebPage({this.link});

  @override
  _PaymentWebPageState createState() => _PaymentWebPageState();
}

class _PaymentWebPageState extends State<PaymentWebPage> {
  // final _key = UniqueKey();
  WebViewController _controller;
  GetSnackBar getSnackBar;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    print("nhattu");
    print(widget.link);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: WebView(
        initialUrl: widget.link,
        javascriptMode: JavascriptMode.unrestricted,
        gestureNavigationEnabled: true,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageFinished: (url) {
          print("linkurl");
          print(url);
          if (url
              .toLowerCase()
              .startsWith('$baseUrl/user/successPayPal'.toLowerCase())) {
            // pickAddressController.disposeFormInput();
            getSnackBar = GetSnackBar(
              title: 'Thanh toán thành công!',
              subTitle: 'Hãy theo dõi quá trình vận đơn',
            );
            Get.offAllNamed(Routes.PAYMENT_SUCCESS);
            getSnackBar.show();
          } else if (url
              .toLowerCase()
              .startsWith('$baseUrl/user/failVnPay'.toLowerCase())) {
            // pickAddressController.disposeFormInput();
            getSnackBar = GetSnackBar(
              title: 'Thanh toán thất bại!',
              subTitle: 'Bạn chưa thanh toán đơn hàng này!',
            );
            Get.offAllNamed(Routes.PAYMENT_ERROR);
            getSnackBar.show();
          } else if (url
              .toLowerCase()
              .startsWith('$baseUrl/user/successVnPay'.toLowerCase())) {
            // pickAddressController.disposeFormInput();
            getSnackBar = GetSnackBar(
              title: 'Thanh toán thành công!',
              subTitle: 'Hãy theo dõi quá trình vận đơn',
            );
            Get.offAllNamed(Routes.PAYMENT_SUCCESS);
            getSnackBar.show();
          }
        },
      ),
    );
  }
}
