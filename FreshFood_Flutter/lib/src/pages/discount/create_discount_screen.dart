import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/pages/Admin/controller/admin_controller.dart';
import 'package:freshfood/src/pages/discount/controllers/discount_controlller.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/admin_repository.dart';
import 'package:freshfood/src/repository/discount_repository.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CreateDiscountPage extends StatefulWidget {
  @override
  _CreateDiscountPageState createState() => _CreateDiscountPageState();
}

class _CreateDiscountPageState extends State<CreateDiscountPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode textFieldFocus = FocusNode();
  double percentDiscount;
  int maxDiscount;
  int minimumDiscount;
  int quantity;
  final discountController = Get.put(DiscountController());

  bool hidePassword = true;

  hideKeyboard() => textFieldFocus.unfocus();

  Future<void> _selectDateFrom(BuildContext context, title, initial) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020, 10),
      lastDate: DateTime(2023, 10),
    );
    if (picked != null) {
      if (title == 'Từ') {
        discountController.setStartTime(picked);
      } else if (title == 'Đến') {
        discountController.setEndTime(picked);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    discountController.initDateTime();
  }

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
          'Tạo voucher',
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
            child: GetBuilder<DiscountController>(
              builder: (_) => SingleChildScrollView(
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
                                  'Phần trăm giảm (%)',
                                  'Hãy nhập phần trăm giảm',
                                ),
                                _buildDivider(context),
                                _buildLineInfo(
                                  context,
                                  'Giảm tối đa (vnđ)',
                                  'Hãy nhập số tiền giảm tối đa',
                                ),
                                _buildDivider(context),
                                _buildLineInfo(
                                  context,
                                  'Đơn tối thiểu (vnđ)',
                                  'Hãy nhập giá đơn thấp nhất để nhận giảm giá',
                                ),
                                _buildDivider(context),
                                _buildLineInfo(
                                  context,
                                  'Số lượng',
                                  'Hãy nhập số lượng voucher',
                                ),
                                _buildDivider(context),
                                _buildPickDate('Từ', _.startTime),
                                _buildDivider(context),
                                _buildPickDate('Đến', _.endTime),
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
                                DiscountRepository()
                                    .createDiscount(
                                        percentDiscount: percentDiscount,
                                        duration: discountController.endTime,
                                        startTime: discountController.startTime,
                                        maxDiscount: maxDiscount,
                                        minimumDiscount: minimumDiscount,
                                        quantity: quantity)
                                    .then((value) {
                                  Get.back();
                                  if (value == null) {
                                    GetSnackBar getSnackBar = GetSnackBar(
                                      title: 'Tạo voucher thất bại',
                                      subTitle: 'Vui lòng nhập đủ các trường',
                                    );
                                    getSnackBar.show();
                                  } else {
                                    discountController.initialController();
                                    discountController.getAllDiscount();
                                    GetSnackBar getSnackBar = GetSnackBar(
                                      title: 'Tạo voucher thành công',
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
        keyboardType: TextInputType.number,
        validator: (val) {
          return val.trim().length == 0 ? valid : null;
        },
        onChanged: (val) {
          setState(() {
            if (title == 'Phần trăm giảm (%)') {
              percentDiscount = double.parse(val.trim());
            } else if (title == 'Giảm tối đa (vnđ)') {
              maxDiscount = int.parse(val.trim());
            } else if (title == 'Đơn tối thiểu (vnđ)') {
              minimumDiscount = int.parse(val.trim());
            } else if (title == 'Số lượng') {
              quantity = int.parse(val.trim());
            }
          });
        },
        inputFormatters: [
          title != 'Phần trăm giảm (%)'
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
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

  Widget _buildPickDate(title, initial) {
    return Row(
      children: [
        SizedBox(width: 20.sp),
        Expanded(
          flex: 2,
          child: Text(
            '$title: ',
            style: TextStyle(
              color: colorPrimary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: GestureDetector(
            onTap: () async {
              _selectDateFrom(context, title, initial);
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 18.0,
                right: 12.0,
                top: 12.0,
                bottom: 12.0,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              // decoration:
              //     AppDecoration.buttonActionBorder(context, 4.sp).decoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy').format(initial),
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(
                    PhosphorIcons.calendar_bold,
                    size: 20.sp,
                    color: Colors.grey.shade700,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 6.sp),
      ],
    );
  }
}
