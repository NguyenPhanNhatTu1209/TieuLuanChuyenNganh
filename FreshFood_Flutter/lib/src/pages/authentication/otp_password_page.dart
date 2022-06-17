import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/app.dart';
import 'package:freshfood/src/pages/home/home_page.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/authentication_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:otp_screen/otp_screen.dart';
import 'package:sizer/sizer.dart';

class OtpPassPage extends StatefulWidget {
  String email;
  OtpPassPage({this.email});
  @override
  State<StatefulWidget> createState() => _OtpPassPageState();
}

class _OtpPassPageState extends State<OtpPassPage> {
  GetSnackBar getSnackBar;
  bool check = false;
  String tokenUser;

  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    await AuthenticationRepository()
        .confirmOtp(widget.email, otp)
        .then((value) {
      if (value != null) {
        tokenUser = value['token'];
        check = true;
      } else {
        check = false;
      }
    });
    if (check == false) {
      return "Mã OTP của bạn không đúng hoặc đã hết hạn";
    } else {
      return null;
    }
    // if (otp == "123456") {
    //   return null;
    // } else {
    //   return "Mã OTP của bạn không đúng hoặc đã hết hạn";
    // }
  }

  void moveToNextScreen(context) {
    Get.toNamed(Routes.CHANGEPASSWORDWITHOTP, arguments: {"token": tokenUser});
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        width: 70.w,
        child: Drawer(
          child: DrawerLayout(),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            PhosphorIcons.arrow_left,
            color: Colors.black,
          ),
          onPressed: () => {Get.back()},
          iconSize: 30,
        ),
        title: Text(
          "Nhập mã OTP",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        // debugShowCheckedModeBanner: false,
        // initialize the OTP screen by passing validation logic and route callback
        child: OtpScreen.withGradientBackground(
          topColor: kPrimaryColor,
          bottomColor: Colors.green[100],
          otpLength: 6,
          validateOtp: validateOtp,
          routeCallback: moveToNextScreen,
          themeColor: Colors.white,
          titleColor: Colors.white,
          title: "Xác thực OTP",
          subTitle: "Nhập mã code đã gửi cho Email hoặc Số điện thoại của bạn",
          icon: Image.asset(
            'assets/images/OTP2.png',
          ),
        ),
      ),
    );
  }
}
