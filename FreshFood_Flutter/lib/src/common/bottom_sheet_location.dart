import 'package:flutter/material.dart';
import 'package:freshfood/src/public/province_district.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BottomSheet_Location extends StatefulWidget {
  final Function handleAccept;
  final String name, textProvinceSelected, textDistrictSelected;

  /*
  0 : province
  1 : district
  */
  final int typeLocation;

  const BottomSheet_Location(
      {this.textProvinceSelected = "",
      this.textDistrictSelected = "",
      this.handleAccept,
      this.name = '',
      this.typeLocation = 0});

  @override
  _BottomSheet_LocationScreenState createState() =>
      _BottomSheet_LocationScreenState();
}

class _BottomSheet_LocationScreenState extends State<BottomSheet_Location> {
  List _dataLocation;
  String textCurrent = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataLocation = widget.typeLocation == 0
        ? Province().renderProvinceArray()
        : District().getDistrictListByProvinceCode(
            Province().getCodeOfProvince(widget.textProvinceSelected));

    if (widget.typeLocation == 0 && widget.textProvinceSelected != "") {
      this.setState(() {
        textCurrent = widget.textProvinceSelected;
      });
    }
    if (widget.typeLocation == 1 && widget.textDistrictSelected != "") {
      this.setState(() {
        textCurrent = widget.textDistrictSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataLocationForFilter = widget.typeLocation == 0
        ? Province().renderProvinceArray()
        : District().getDistrictListByProvinceCode(
            Province().getCodeOfProvince(widget.textProvinceSelected));

    print(_dataLocation);
    return SafeArea(
      child: Container(
          width: double.infinity,
          height: 100.h,
          color: Colors.white,
          padding: EdgeInsets.only(
              left: 10.sp, right: 10.sp, top: 6.h, bottom: 20.sp),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 30.sp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: double.infinity,
                        padding: EdgeInsets.only(right: 10.sp),
                        child: Center(
                            child: Text(
                          'Hủy',
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.green),
                        )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.sp),
                      child: Text(
                          widget.typeLocation == 0
                              ? "Tỉnh/thành phố"
                              : "Quận/huyện",
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (textCurrent != "") widget.handleAccept(textCurrent);
                        Get.back();
                      },
                      child: Container(
                        height: double.infinity,
                        padding: EdgeInsets.only(left: 10.sp),
                        child: Center(
                            child: Text(
                          'Xác nhận',
                          style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.green),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.sp),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                decoration: BoxDecoration(
                    color: Color(0xfffafafb),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {
                      _dataLocation = filterList(dataLocationForFilter, text);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10.sp),
                  width: double.infinity,
                  height: 75.h,
                  child: ListView.builder(
                      itemCount: _dataLocation.length,
                      itemBuilder: (BuildContext context, int index) {
                        return optionItem(
                            handlePress: () {
                              this.setState(() {
                                textCurrent = _dataLocation[index];
                              });
                            },
                            name: _dataLocation[index],
                            isSelected: _dataLocation[index] == textCurrent);
                      }))
            ],
          )),
    );
  }
}

Widget optionItem({Function handlePress, String name, bool isSelected}) {
  return GestureDetector(
    onTap: handlePress,
    child: Container(
      padding: EdgeInsets.only(bottom: 10.sp, top: 5.sp),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: Colors.grey,
          width: 1.0,
        )),
      ),
      width: double.infinity,
      height: 35.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? Colors.green : Colors.black)),
          Container(
            width: 15.sp,
            height: 15.sp,
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1, color: isSelected ? Colors.green : Colors.black)),
            child: Center(
              child: Container(
                width: 10.sp,
                height: 10.sp,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.green : Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
