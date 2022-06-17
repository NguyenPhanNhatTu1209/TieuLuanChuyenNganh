import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/pages/option/controllers/profile_controller.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ProfilePages extends StatefulWidget {
  final UserModel user;
  ProfilePages({this.user});

  @override
  _ProfilePagesState createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  TextEditingController _namecontroller = new TextEditingController();
  TextEditingController _phoneNumbercontroller = new TextEditingController();
  TextEditingController _emailcontroller = new TextEditingController();
  String avatar;
  File _image;
  ImagePicker _imagePicker = ImagePicker();
  final profileController = Get.put(ProfileController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namecontroller.text = widget.user.name;
    _phoneNumbercontroller.text = widget.user.phone;
    _emailcontroller.text = widget.user.email;
    avatar = widget.user.avatar;
  }

  void showImageBottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return _chooseImage(context);
      },
    );
  }

  Widget _chooseImage(context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: mC,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            30.0,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12.0),
            Container(
              height: 4.0,
              margin: EdgeInsets.symmetric(horizontal: _size.width * .35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: mCD,
                boxShadow: [
                  BoxShadow(
                    color: mCD,
                    offset: Offset(2.0, 2.0),
                    blurRadius: 2.0,
                  ),
                  BoxShadow(
                    color: mCL,
                    offset: Offset(-1.0, -1.0),
                    blurRadius: 1.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            _buildAction(
              context,
              'Chụp ảnh',
              PhosphorIcons.instagram_logo_bold,
            ),
            Divider(
              color: Colors.grey,
              thickness: .25,
              height: .25,
              indent: 8.0,
              endIndent: 8.0,
            ),
            _buildAction(
              context,
              'Chọn ảnh từ Album',
              PhosphorIcons.image_square_bold,
            ),
            SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }

  Widget _buildAction(context, title, icon) {
    final _size = MediaQuery.of(context).size;
    Future<void> _pickImage(ImageSource source) async {
      XFile SelectedSource = await _imagePicker.pickImage(source: source);
      if (SelectedSource != null) {
        setState(() {
          _image = File(SelectedSource.path);
        });
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            },
            barrierColor: Color(0x80000000),
            barrierDismissible: false);
        profileController.updateAvatar(_image);
      }
    }

    return GestureDetector(
      onTap: () {
        switch (title) {
          // English
          case 'Take a Photo':
            _pickImage(ImageSource.camera);
            break;
          case 'Choose from Album':
            _pickImage(ImageSource.gallery);
            break;

          // Vietnamese
          case 'Chụp ảnh':
            _pickImage(ImageSource.camera);
            break;
          case 'Chọn ảnh từ Album':
            _pickImage(ImageSource.gallery);
            break;

          default:
            break;
        }
      },
      child: Container(
        width: _size.width,
        color: mC,
        padding: EdgeInsets.fromLTRB(24.0, 15.0, 20.0, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: _size.width / 16.0,
                  color: Colors.grey.shade800,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: _size.width / 22.5,
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent, elevation: 0, actions: []),
      body: Form(
        key: _formKey,
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
                              Positioned(
                                right: -16,
                                bottom: 0,
                                child: SizedBox(
                                  height: 46,
                                  width: 46,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: BorderSide(color: Colors.white),
                                      ),
                                      primary: Colors.white,
                                      backgroundColor: Color(0xFFF5F6F9),
                                    ),
                                    onPressed: showImageBottomSheet,
                                    child: Icon(
                                      PhosphorIcons.camera_bold,
                                      color: Colors.black, // Pencil Icon
                                    ),
                                  ),
                                ),
                              )
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
                            'Điền họ và tên của bạn',
                            'Họ và tên',
                            PhosphorIcons.user),
                        SizedBox(
                          height: 30.0,
                        ),
                        BuildTextField('Vui lòng điền email!', _emailcontroller,
                            'Điền Email', 'Email', PhosphorIcons.envelope),
                        SizedBox(
                          height: 30.0,
                        ),
                        BuildTextField(
                            'Vui lòng điền số điện thoại',
                            _phoneNumbercontroller,
                            'Điền số điện thoại',
                            'Số điện thoại',
                            PhosphorIcons.phone),
                        SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
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
                                  barrierDismissible: false,
                                );

                                UserRepository()
                                    .updateUser(
                                        phone:
                                            _phoneNumbercontroller.text.trim(),
                                        name: _namecontroller.text.trim())
                                    .then((value) {
                                  Get.back();
                                  if (value == false) {
                                    GetSnackBar getSnackBar = GetSnackBar(
                                      title: 'Sửa thông tin thất bại!',
                                      subTitle: '',
                                    );
                                    getSnackBar.show();
                                  } else {
                                    userProvider.user.name =
                                        _namecontroller.text.trim();
                                    userProvider.user.phone =
                                        _phoneNumbercontroller.text.trim();
                                    userProvider
                                        .setUserProvider(userProvider.user);
                                    Get.back();
                                    GetSnackBar getSnackBar = GetSnackBar(
                                      title: 'Thành công',
                                      subTitle: 'Cập nhật thông tin thành công',
                                    );
                                    getSnackBar.show();
                                  }
                                });
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  border: Border.all(
                                      width: 2, color: kPrimaryColor),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Lưu thông tin',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
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
      String placeholder, String lable_text, IconData iconData) {
    return Material(
      elevation: 20.0,
      shadowColor: kPrimaryColor.withOpacity(0.2),
      child: TextFormField(
        readOnly: lable_text == "Email" ? true : false,
        controller: name_controller,
        validator: (val) => val.trim().length == 0 ? vali : null,
        onChanged: (val) {
          // name_controller.text = val.trim();
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
