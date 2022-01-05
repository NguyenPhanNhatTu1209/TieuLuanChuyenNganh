import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/pages/option/controllers/profile_controller.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ManagerUserDetail extends StatefulWidget {
  final UserModel user;
  ManagerUserDetail({this.user});

  @override
  _ManagerUserDetailState createState() => _ManagerUserDetailState();
}

class _ManagerUserDetailState extends State<ManagerUserDetail> {
  TextEditingController _namecontroller = new TextEditingController();
  TextEditingController _phoneNumbercontroller = new TextEditingController();
  TextEditingController _emailcontroller = new TextEditingController();
  String avatar;
  File _image;
  ImagePicker _imagePicker = ImagePicker();
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namecontroller.text = widget.user.name;
    _phoneNumbercontroller.text = widget.user.phone;
    _emailcontroller.text = widget.user.email;
    avatar = widget.user.avatar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent, elevation: 0, actions: []),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 35.h,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      kPrimaryColor.withOpacity(0.6),
                      kPrimaryColor.withOpacity(0.2)
                    ])),
                child: Container(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                backgroundImage: _image == null
                                    ? NetworkImage(avatar)
                                    : FileImage(
                                        _image,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                )),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),
                        BuildTextField(
                            'Vui lòng điền tên của bạn!',
                            _namecontroller,
                            "name",
                            'Điền họ và tên của bạn',
                            'Họ và tên',
                            PhosphorIcons.user),
                        SizedBox(
                          height: 30.0,
                        ),
                        BuildTextField(
                            'Vui lòng điền email!',
                            _emailcontroller,
                            "name",
                            'Điền Email',
                            'Email',
                            PhosphorIcons.envelope),
                        SizedBox(
                          height: 30.0,
                        ),
                        BuildTextField(
                            'Vui lòng điền số điện thoại',
                            _phoneNumbercontroller,
                            "name",
                            'Điền số điện thoại',
                            'Số điện thoại',
                            PhosphorIcons.phone),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material BuildTextField(String vali, TextEditingController name_controller,
      String name, String placeholder, String lable_text, IconData iconData) {
    return Material(
      elevation: 20.0,
      shadowColor: kPrimaryColor.withOpacity(0.2),
      child: TextFormField(
        readOnly: true,
        controller: name_controller,
        validator: (val) => val.trim().length == 0 ? vali : null,
        onChanged: (val) {
          name = val.trim();
        },
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          fillColor: Colors.black,
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          labelText: lable_text,
          prefixIcon: Container(
              child: new Icon(
            iconData,
            color: Colors.black,
          )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(color: Colors.black, width: 1)),
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
