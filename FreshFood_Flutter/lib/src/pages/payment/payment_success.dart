import 'package:flutter/material.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';

class PaymentSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/images/success.gif')),
          Text(
            'Bạn đã thanh toán thành công',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          DefaultButton(
            btnText: 'Ok',
            onPressed: () {
              Get.offAllNamed(Routes.ROOT);
            },
          )
        ],
      ),
    );
  }
}
