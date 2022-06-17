import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/repository/authentication_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChangePasswordPage extends StatefulWidget {
  final VoidCallback toggleView;

  ChangePasswordPage({this.toggleView});
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  FocusNode textFieldFocus = FocusNode();
  String fullName = '';
  String confirmPassword = '';
  String phone = '';
  String email = '';
  String password = '';
  String passwordOld = '';

  bool hidePassword = true;

  hideKeyboard() => textFieldFocus.unfocus();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'Đổi mật khẩu',
          style: TextStyle(
            color: Colors.white,
            fontSize: _size.width / 20.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: _size.height,
        width: _size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
              .95,
              .0,
            ), // 10% of the width, so there are ten blinds.
            colors: [
              Colors.green.shade50,
              Colors.white,
            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Form(
          key: _formKey,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: .0),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _size.width * 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 12.0),
                              _buildLineInfo(
                                context,
                                'Mật khẩu cũ',
                                'Mật khẩu phải có ít nhất 6 kí tự',
                              ),
                              SizedBox(height: 12.0),
                              _buildDivider(context),
                              _buildLineInfo(
                                context,
                                'Mật khẩu',
                                'Mật khẩu phải có ít nhất 6 kí tự',
                              ),
                              _buildDivider(context),
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(14.0, 24.0, 18.0, 4.0),
                                child: TextFormField(
                                  // controller: _confirmPswController,
                                  cursorColor: Color(0xFF2C3D50),
                                  cursorRadius: Radius.circular(30.0),
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: _size.width / 26.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  validator: (val) => val.trim() != password
                                      ? 'Mật khẩu không trùng khớp'
                                      : null,
                                  obscureText: hidePassword,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.only(
                                      left: 12.0,
                                    ),
                                    border: InputBorder.none,
                                    labelText: 'Nhập lại mật khẩu'.trArgs(),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF2C3D50),
                                      fontSize: _size.width / 26.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              _buildDivider(context),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.0),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    );
                                  },
                                  barrierColor: Color(0x80000000),
                                  barrierDismissible: false);
                              AuthenticationRepository()
                                  .changePassword(passwordOld, password)
                                  .then((value) {
                                Get.back();
                                if (value == false) {
                                  GetSnackBar getSnackBar = GetSnackBar(
                                    title: 'Đổi mật khẩu thất bại!',
                                    subTitle: 'Sai mật khẩu cũ',
                                  );
                                  getSnackBar.show();
                                } else {
                                  GetSnackBar getSnackBar = GetSnackBar(
                                    title: 'Đổi mật khẩu thành công',
                                    subTitle: '',
                                  );
                                  Get.offAllNamed(Routes.ROOT);
                                  getSnackBar.show();
                                }
                              });
                            }
                          },
                          child: Container(
                            height: 46.8,
                            margin: EdgeInsets.symmetric(
                              horizontal: _size.width * .12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              color: Color(0xFF2C3D50),
                            ),
                            child: Center(
                              child: Text(
                                'Lưu chỉnh sửa',
                                style: TextStyle(
                                  color: Colors.pinkAccent.shade100,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 36.0),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLineInfo(context, title, valid) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(14.0, 18.0, 18.0, 4.0),
      child: TextFormField(
        cursorColor: Color(0xFF2C3D50),
        cursorRadius: Radius.circular(30.0),
        style: TextStyle(
          color: Color(0xFF2C3D50),
          fontSize: _size.width / 26.0,
          fontWeight: FontWeight.w500,
        ),
        validator: (val) {
          if (title == 'Mật khẩu' || title == 'Mật khẩu cũ') {
            return val.trim().length < 6 ? valid : null;
          }
          return null;
        },
        onChanged: (val) {
          setState(() {
            if (title == 'Mật khẩu') {
              password = val.trim();
            } else if (title == 'Mật khẩu cũ') {
              passwordOld = val.trim();
            }
          });
        },
        obscureText:
            title == 'Mật khẩu' || title == 'Mật khẩu cũ' ? true : false,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.only(
            left: 12.0,
          ),
          border: InputBorder.none,
          labelText: title,
          labelStyle: TextStyle(
            color: Color(0xFF2C3D50),
            fontSize: _size.width / 26.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(context) {
    return Divider(
      color: Colors.grey.shade500,
      thickness: .25,
      height: .25,
      indent: 25.0,
      endIndent: 25.0,
    );
  }
}
