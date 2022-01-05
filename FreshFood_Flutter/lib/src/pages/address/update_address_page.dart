import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/address.dart';
import 'package:freshfood/src/models/history.dart';
import 'package:freshfood/src/pages/payment/controller/addressController.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/public/constant.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UpdateAddressPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
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
            "Sửa địa chỉ nhận hàng",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Container(
          height: 90.h,
          child: GetBuilder<AddressController>(
            init: addressController,
            builder: (_) => ListView.builder(
              controller: scrollController,
              itemCount: addressController.listAddress.length,
              itemBuilder: (context, index) {
                return WidgetAddress(
                  addressModel: addressController.listAddress[index],
                );
              },
            ),
          ),
        ));
  }
}

class WidgetAddress extends StatelessWidget {
  AddressModel addressModel;
  WidgetAddress({Key key, this.addressModel});
  final addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.UPDATE_ADDRESS_PAGE_DETAIL,
            arguments: {"address": addressModel});
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              //                   <--- left side
              color: Colors.grey.shade300,
              width: 2.sp,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '${addressModel.name}',
                  style: TextStyle(
                    // color: colorTitle,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Text(
                  addressModel.isMain == true ? '[Mặc định]' : '',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.sp,
            ),
            Container(
              child: Row(children: [
                Column(children: [
                  Container(
                    width: 265.sp,
                    child: Text(
                      '(+84) ${addressModel.phone}',
                      style: TextStyle(
                        // color: colorTitle,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Row(children: [
                    Container(
                      width: 210.sp,
                      child: Text(
                        '${addressModel.address}',
                        style: TextStyle(
                          // color: colorTitle,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    addressModel.id == addressController.addressSelected.id
                        ? Icon(
                            PhosphorIcons.check,
                            color: Colors.red,
                          )
                        : Container()
                  ]),
                  Row(children: [
                    Container(
                      width: 210.sp,
                      child: Text(
                        '${addressModel.province} - ${addressModel.district}',
                        style: TextStyle(
                          // color: colorTitle,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Icon(
                      PhosphorIcons.map_pin,
                      color: Colors.red,
                    )
                  ]),
                ]),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
