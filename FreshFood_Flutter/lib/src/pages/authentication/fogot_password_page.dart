import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/authentication_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String email;
  @override
  void initState() {
    super.initState();
    email = "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
              onPressed: () => Get.back(),
              icon: Icon(
                PhosphorIcons.arrow_left,
                color: Colors.white,
                size: 7.w,
              ),
            ),
            title: Text(
              "Quên mật khẩu",
              style: TextStyle(fontSize: 20),
            ),
          ),
          body: Container(
              height: 100.h,
              width: 100.w,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20.sp, bottom: 20.sp),
                    child: Text(
                      "Nhập Email Của bạn",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.sp),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      validator: (val) => val.trim().length == 0
                          ? 'Hãy nhập email của bạn'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          email = val.trim();
                        });
                      },
                      decoration: const InputDecoration(
                          labelText: "Email",
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          alignLabelWithHint: true,
                          // border: Border.all(color: Colors.blueAccent),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0)),
                          fillColor: Colors.grey),
                      maxLines: 1,
                    ),
                  ),
                  DefaultButton(
                    btnText: "Gửi",
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        AuthenticationRepository()
                            .forgotPassword(email)
                            .then((value) {
                          if (value == true) {
                            // GetSnackBar getSnackBar = GetSnackBar(
                            //   title: 'Gửi thành công',
                            //   subTitle:
                            //       'OTP đã được gửi về email hoặc điện thoại tương ứng',
                            // );

                            Get.toNamed(Routes.OTP,
                                arguments: {"email": email});
                            // getSnackBar.show();
                          } else {
                            GetSnackBar getSnackBar = GetSnackBar(
                              title: 'Email không tồn tại',
                              subTitle: '',
                            );
                            getSnackBar.show();
                          }
                        });
                      }
                    },
                  )
                ],
              ))),
    );
  }
}
