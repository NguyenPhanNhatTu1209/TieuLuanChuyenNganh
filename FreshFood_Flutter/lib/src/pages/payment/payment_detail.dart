import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/models/order.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/payment/controller/addressController.dart';
import 'package:freshfood/src/pages/payment/controller/payment_controller.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PaymentDetailPage extends StatefulWidget {
  List<CartModel> list;
  bool isBuyNow;
  PaymentDetailPage({this.list, this.isBuyNow});
  @override
  State<StatefulWidget> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  final addressController = Get.put(AddressController());
  final paymentController = Get.put(PaymentController());
  TextEditingController _noteController = TextEditingController();

  double heighContainer;
  @override
  void initState() {
    super.initState();
    paymentController.list = widget.list;
    heighContainer = 95.sp * widget.list.length;
    addressController.getAllAddress();
    _noteController.text = paymentController.note;
    print('start');
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
            "Thanh Toán",
            style: TextStyle(fontSize: 17.sp),
          ),
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  splashColor: Colors.greenAccent,
                  onTap: () {
                    Get.toNamed(Routes.ADDRESS);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 20),
                    margin: EdgeInsets.only(
                      top: 25.0,
                    ),
                    child: Row(children: [
                      Icon(
                        PhosphorIcons.map_pin_line,
                        size: 20.sp,
                      ),
                      SizedBox(
                        width: 16.sp,
                      ),
                      Expanded(
                        child: GetBuilder<AddressController>(
                            init: addressController,
                            builder: (_) => _.addressSelected == null
                                ? Text(
                                    'Bạn chưa có địa chỉ, vui lòng chọn địa chỉ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 2.5.w),
                                  )
                                : Text(
                                    ' ${_.addressSelected.address} - ${_.addressSelected.district} - ${_.addressSelected.province}',
                                    style: TextStyle(
                                      // color: colorTitle,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                      ),
                    ]),
                  ),
                ),
                Container(
                  height: heighContainer,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.list.length,
                    itemBuilder: (context, index) {
                      return CartDetail(
                        cartModel: widget.list[index],
                      );
                    },
                  ),
                ),

                // cart image
                Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(
                    top: 25.0,
                    bottom: 12.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.note,
                        size: 20.sp,
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Text(
                        'Tin nhắn:',
                        style: TextStyle(
                          // color: colorTitle,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                          child: TextField(
                        onChanged: (value) {
                          paymentController.note = value;
                        },
                        textAlign: TextAlign.end,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Nhập ghi chú cho đơn hàng',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      )),
                      SizedBox(
                        width: 10.sp,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(
                    top: 25.0,
                    bottom: 12.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.money,
                        size: 20.sp,
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Text(
                        'Tổng Số tiền:',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Text(
                        formatMoney(
                            paymentController.getproductPrice(widget.list)),
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(
                    top: 25.0,
                    bottom: 12.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            PhosphorIcons.currency_circle_dollar,
                            size: 20.sp,
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Text(
                            'Phương thức thanh toán:',
                            style: TextStyle(
                              // color: colorTitle,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.METHOD_PAYMENT);
                              },
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(fontSize: 12.sp),
                              ),
                              child: GetBuilder<PaymentController>(
                                init: paymentController,
                                builder: (_) => _.methodPayment == null
                                    ? Text(
                                        'Phương thức thanh toán',
                                        maxLines: 3,
                                        style: TextStyle(color: Colors.orange),
                                      )
                                    : Text(
                                        paymentController.getPaymentMethod(),
                                        maxLines: 3,
                                        style: TextStyle(color: Colors.orange),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Row(
                        children: [
                          Text(
                            'Tổng tiền hàng:',
                            style: TextStyle(
                              // color: colorTitle,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 110.sp,
                          ),
                          Text(
                            formatMoney(
                                paymentController.getproductPrice(widget.list)),
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(children: [
                        Text(
                          'Tổng phí vận chuyển:',
                          style: TextStyle(
                            // color: colorTitle,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 80.sp,
                        ),
                        GetBuilder<PaymentController>(
                          init: paymentController,
                          builder: (_) => Text(
                            formatMoney(paymentController.transportFee),
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(children: [
                        Text(
                          'Tổng thanh toán:',
                          style: TextStyle(
                            // color: colorTitle,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 80.sp,
                        ),
                        GetBuilder<PaymentController>(
                          init: paymentController,
                          builder: (_) => Text(
                            formatMoney(paymentController.total),
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                ),
                DefaultButton(
                  btnText: 'Đồng ý',
                  onPressed: () {
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
                        barrierDismissible: false);
                    paymentController.createOrder(widget.list, widget.isBuyNow);
                  },
                )
              ],
            ),
          ),
        ));
  }
}

class CartDetail extends StatelessWidget {
  CartModel cartModel;
  CartDetail({Key key, this.cartModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.sp,
      padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
      margin: EdgeInsets.only(
        top: 20.sp,
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: 5.sp, right: 10.sp),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border:
              Border(bottom: BorderSide(color: Colors.black45, width: 1.sp)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10.sp,
            ),
            Container(
              child: CachedNetworkImage(
                imageUrl: cartModel.image[0],
                fit: BoxFit.cover,
                height: 70.sp,
                width: 70.sp,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 20.sp,
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      cartModel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 5.sp),
                    child: Text(
                      "x${cartModel.quantity}",
                      style: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 5.sp),
                    child: Text(
                      formatMoney(cartModel.cost),
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
