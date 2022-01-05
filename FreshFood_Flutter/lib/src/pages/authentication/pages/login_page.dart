import 'package:flutter/material.dart';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/pages/home/home_page.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/authentication_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';

class LoginPages extends StatefulWidget {
  final VoidCallback toggleView;

  LoginPages({this.toggleView});

  @override
  _LoginPagesState createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: _size.height,
        width: _size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
              .90,
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
            child: ListView(children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Image(
                        image: AssetImage('images/freshfood1.png'),
                        height: 100,
                        width: 200,
                        fit: BoxFit.contain,
                      ))
                    ],
                  )),
              Container(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                  child: TextFormField(
                      // controller: _emailController,
                      validator: (val) => val.trim().length == 0
                          ? 'Nhập email mới đc đăng kí'
                          : null,
                      onChanged: (val) {
                        setState(() {
                          email = val.trim();
                        });
                      },
                      keyboardType: TextInputType
                          .emailAddress, // Use email input type for emails.
                      decoration: InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'E-mail Address',
                          icon: Icon(Icons.email)))),
              Container(
                padding:
                    const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                child: TextFormField(
                    // controller: _passwordController,
                    validator: (val) => val.trim().length < 6
                        ? 'Mật khẩu phải có tối thiểu 6 kí tự'
                        : null,
                    onChanged: (val) {
                      password = val.trim();
                    },
                    obscureText: _isObscure, // Use secure text for passwords.
                    decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Enter your password',
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        icon: Icon(Icons.lock))),
              ),
              GestureDetector(
                onTap: () {
                  widget.toggleView();
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 24.0,
                    bottom: 12.0,
                  ),
                  child: Center(
                    child: Text(
                      'Bạn chưa có tài khoản? Đăng kí ngay',
                      style: TextStyle(
                        // color: colorTitle,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      },
                      barrierColor: Color(0x80000000),
                      barrierDismissible: false,
                    );
                    AuthenticationRepository()
                        .login(email, password)
                        .then((value) {
                      Get.back();
                      if (value == null) {
                        GetSnackBar getSnackBar = GetSnackBar(
                          title: 'Đăng nhập thất bại!',
                          subTitle: 'Sai tài khoản hoặc mật khẩu',
                        );
                        getSnackBar.show();
                      } else {
                        userProvider.setUser(
                          UserModel.fromLogin(value),
                        );
                        print("dang nhap thanh cong");
                        GetSnackBar getSnackBar = GetSnackBar(
                          title: 'Đăng nhập thành công!',
                          subTitle: 'Đăng nhập thành công',
                        );
                        getSnackBar.show();
                      }
                    });
                  }
                },
                child: Container(
                  height: 46.8,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: colorTitle,
                  ),
                  child: Center(
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(
                        color: Colors.pinkAccent.shade100,
                        fontSize: 12.8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.FORGOT_PASSWORD);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    top: 24.0,
                    bottom: 12.0,
                  ),
                  child: Center(
                    child: Text(
                      'Quên mật khẩu?',
                      style: TextStyle(
                        // color: colorTitle,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
