import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/pages/Admin/controller/admin_controller.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/repository/admin_repository.dart';
import 'package:freshfood/src/repository/authentication_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';

class CreateStaffPage extends StatefulWidget {
  final VoidCallback toggleView;

  CreateStaffPage({this.toggleView});
  @override
  _CreateStaffPageState createState() => _CreateStaffPageState();
}

class _CreateStaffPageState extends State<CreateStaffPage> {
  final _formKey = GlobalKey<FormState>();

  FocusNode textFieldFocus = FocusNode();
  String fullName = '';
  String confirmPassword = '';
  String phone = '';
  String email = '';
  String password = '';
  final adminController = Get.put(AdminController());

  bool hidePassword = true;

  hideKeyboard() => textFieldFocus.unfocus();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: .0,
        backgroundColor: Colors.green.shade50,
        brightness: Brightness.light,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            PhosphorIcons.arrow_left,
            color: Color(0xFF2C3D50),
            size: _size.width / 15.0,
          ),
        ),
        title: Text(
          'Tạo nhân viên',
          style: TextStyle(
            color: Color(0xFF2C3D50),
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
                          // decoration: BoxDecoration(
                          //   color: Colors.green.shade50,
                          //   boxShadow: [
                          //     BoxShadow(
                          //       color: Colors.green.shade50,
                          //       offset: Offset(-10, -10),
                          //       blurRadius: 10,
                          //     ),
                          //   ],
                          // ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 12.0),
                              _buildLineInfo(
                                context,
                                'Email',
                                'Hãy nhập định dạng email',
                              ),
                              _buildDivider(context),
                              _buildLineInfo(
                                context,
                                'Số điện thoại',
                                'Hãy nhập số điện thoại của bạn',
                              ),
                              _buildDivider(context),
                              _buildLineInfo(
                                context,
                                'Tên của bạn',
                                'Hãy nhập tên của bạn',
                              ),
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
                              AdminRepository()
                                  .createStaff(email, phone, password, fullName)
                                  .then((value) {
                                Get.back();
                                if (value == null) {
                                  GetSnackBar getSnackBar = GetSnackBar(
                                    title: 'Tạo nhân viên thất bại',
                                    subTitle: 'Email đã được đăng kí.',
                                  );
                                  getSnackBar.show();
                                } else {
                                  adminController.initialController();
                                  adminController.getAllStaff(
                                    search: '',
                                  );
                                  GetSnackBar getSnackBar = GetSnackBar(
                                    title: 'Tạo nhân viên thành công',
                                    subTitle: '',
                                  );
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
                                'Tạo',
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
        keyboardType: title == 'Số điện thoại' ? TextInputType.number : null,
        validator: (val) {
          if (title == 'Email') {
            return GetUtils.isEmail(val.trim()) ? null : valid;
          } else if (title == 'Số điện thoại') {
            return GetUtils.isPhoneNumber(val.trim()) ? null : valid;
          } else if (title == 'Tên của bạn') {
            return val.trim().length == 0 ? valid : null;
          } else if (title == 'Mật khẩu') {
            return val.trim().length < 6 ? valid : null;
          }
          return null;
        },
        onChanged: (val) {
          setState(() {
            if (title == 'Email') {
              email = val.trim();
            } else if (title == 'Số điện thoại') {
              phone = val.trim();
            } else if (title == 'Tên của bạn') {
              fullName = val.trim();
            } else if (title == 'Mật khẩu') {
              password = val.trim();
            }
          });
        },
        inputFormatters: [
          title == 'Số điện thoại'
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
        obscureText: title == 'Mật khẩu' ? true : false,
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
