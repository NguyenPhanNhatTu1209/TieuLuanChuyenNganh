import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/common/bottom_sheet_location.dart';
import 'package:freshfood/src/pages/address/widget/option.dart';
import 'package:freshfood/src/pages/payment/controller/addressController.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/repository/user_repository.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditAddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  bool isMain = false;
  String province = '', distric = '', name = '', phone = '', address = '';
  final addressController = Get.put(AddressController());

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
            onPressed: () => Get.back(),
            icon: Icon(
              PhosphorIcons.arrow_left,
              color: Colors.white,
              size: 7.w,
            ),
          ),
          title: Text(
            "Thêm địa chỉ",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          color: Colors.grey[200],
          padding: EdgeInsets.all(5.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15.sp),
                  width: 270.sp,
                  child: Text(
                    'Liên hệ:',
                    style: TextStyle(
                      // color: colorTitle,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 5.sp),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                        labelText: "Họ và tên",
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        // border: Border.all(color: Colors.blueAccent),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0)),
                        fillColor: Colors.grey),
                    maxLines: 1,
                    onChanged: (val) {
                      name = val.trim();
                    },
                    validator: (String value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                ),
                SizedBox(height: 10.sp),
                Container(
                  color: Colors.white,
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                        labelText: "Số điện thoại",
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        // border: Border.all(color: Colors.blueAccent),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0)),
                        fillColor: Colors.grey),
                    onChanged: (val) {
                      phone = val.trim();
                    },
                    maxLines: 1,
                    validator: (String value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.sp),
                  width: 270.sp,
                  child: Text(
                    'Địa Chỉ:',
                    style: TextStyle(
                      // color: colorTitle,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 2.w),
                Option(
                  handlePress: () {
                    {
                      showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return BottomSheet_Location(
                                typeLocation: 0,
                                textProvinceSelected: province,
                                handleAccept: (value) {
                                  this.setState(() {
                                    province = value;
                                    distric = '';
                                  });
                                });
                          });
                    }
                  },
                  name: 'Tỉnh/thành phố',
                  description: province == '' ? 'Xin chọn' : province,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Option(
                  handlePress: province == ''
                      ? () {}
                      : () {
                          showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return BottomSheet_Location(
                                    typeLocation: 1,
                                    textProvinceSelected: province,
                                    textDistrictSelected: distric,
                                    handleAccept: (value) {
                                      this.setState(() {
                                        distric = value;
                                      });
                                    });
                              });
                        },
                  name: 'Quận/huyện',
                  description: distric == '' ? 'Xin chọn' : distric,
                ),
                SizedBox(
                  height: 5.sp,
                ),
                Container(
                  color: Colors.white,
                  height: 40.sp,
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                        labelText: "Địa chỉ cụ thể",
                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        // border: Border.all(color: Colors.blueAccent),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0)),
                        fillColor: Colors.grey),
                    maxLines: 1,
                    onChanged: (val) {
                      address = val.trim();
                    },
                    validator: (String value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.sp),
                  width: 270.sp,
                  child: Text(
                    'Cài đặt:',
                    style: TextStyle(
                      // color: colorTitle,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Container(
                  height: 50.sp,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.sp))),
                  child: SwitchListTile(
                    title: const Text('Đặt làm địa chỉ mặc định'),
                    value: isMain,
                    onChanged: (bool value) {
                      setState(() {
                        isMain = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                DefaultButton(
                  btnText: 'Hoàn Thành',
                  onPressed: () {
                    UserRepository()
                        .addAddress(
                            name, phone, province, distric, address, isMain)
                        .then((value) {
                      if (value == true) {
                        addressController.getAllAddress();
                        GetSnackBar getSnackBar = GetSnackBar(
                          title: 'Thêm địa chỉ thành công',
                          subTitle: '',
                        );
                        Get.back();

                        getSnackBar.show();
                      } else {
                        GetSnackBar getSnackBar = GetSnackBar(
                          title: 'Thêm địa chỉ thất bại',
                          subTitle: '',
                        );
                        getSnackBar.show();
                      }
                    });
                  },
                )
              ],
            ),
          ),
        ));
  }
}
