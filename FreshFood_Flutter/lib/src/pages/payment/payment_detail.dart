import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/pages/discount/controllers/discount_controlller.dart';
import 'package:freshfood/src/pages/payment/controller/addressController.dart';
import 'package:freshfood/src/pages/payment/controller/payment_controller.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
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
  final discountController = Get.put(DiscountController());

  TextEditingController _noteController = TextEditingController();

  double heighContainer;
  @override
  void initState() {
    super.initState();
    paymentController.list = widget.list;
    heighContainer = 95.sp * widget.list.length;
    addressController.getAllAddress();
    _noteController.text = paymentController.note;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscountController>(
        init: discountController,
        builder: (_) => Scaffold(
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
                "Thanh To??n",
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
                                        'B???n ch??a c?? ?????a ch???, vui l??ng ch???n ?????a ch???',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 2.5.w),
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
                            'Tin nh???n:',
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
                              hintText: 'Nh???p ghi ch?? cho ????n h??ng',
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
                            'T???ng S??? ti???n:',
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
                                PhosphorIcons.wallet,
                                size: 20.sp,
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Ph????ng th???c thanh to??n:',
                                  style: TextStyle(
                                    // color: colorTitle,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                flex: 2,
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
                                            'Ph????ng th???c thanh to??n',
                                            maxLines: 3,
                                            style:
                                                TextStyle(color: Colors.orange),
                                          )
                                        : Text(
                                            paymentController
                                                .getPaymentMethod(),
                                            maxLines: 3,
                                            style:
                                                TextStyle(color: Colors.orange),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.sp,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                PhosphorIcons.tag,
                                size: 20.sp,
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Voucher:',
                                  style: TextStyle(
                                    // color: colorTitle,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.sp,
                              ),
                              Expanded(
                                flex: 2,
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(Routes.APPLY_DISCOUNT);
                                  },
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 12.sp),
                                  ),
                                  child: GetBuilder<DiscountController>(
                                    init: discountController,
                                    builder: (_) => _.currentDiscount == null
                                        ? Text(
                                            'Ch???n m?? gi???m',
                                            maxLines: 3,
                                            style:
                                                TextStyle(color: Colors.orange),
                                          )
                                        : Text(
                                            '-' +
                                                formatMoney(discountController
                                                    .moneyDiscount
                                                    .toDouble()),
                                            maxLines: 3,
                                            style:
                                                TextStyle(color: Colors.orange),
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
                          widgetMoney('T???ng ti???n h??ng:',
                              paymentController.getproductPrice(widget.list)),
                          SizedBox(
                            height: 5.sp,
                          ),
                          discountController.currentDiscount != null
                              ? widgetMoney('T???ng voucher gi???m gi??:',
                                  _.moneyDiscount.toDouble())
                              : SizedBox(),
                          SizedBox(
                            height: 5.sp,
                          ),
                          GetBuilder<PaymentController>(
                              init: paymentController,
                              builder: (_) => widgetMoney(
                                  'T???ng ph?? v???n chuy???n:',
                                  paymentController.transportFee)),
                          SizedBox(
                            height: 7.sp,
                          ),
                          GetBuilder<PaymentController>(
                            init: paymentController,
                            builder: (_) => Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "D??ng xu",
                                        style: TextStyle(
                                          // color: colorTitle,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 0.8,
                                        child: CupertinoSwitch(
                                          value: _.isUsePoint,
                                          onChanged: (value) {
                                            if (_.usePoint == 0) {
                                              return;
                                            }
                                            _.changeStatusUsePoint();
                                            // if (value &&
                                            //     widget.groupQuestion.numberQuestion == 0) {
                                            //   GetSnackBar getSnackBar = GetSnackBar(
                                            //     title: 'Vui l??ng th??m c??u h???i tr?????c',
                                            //     subTitle:
                                            //         'Kh??ng th??? m??? b??? c??u h???i khi ch??a c?? c??u n??o',
                                            //   );
                                            //   getSnackBar.show();
                                            //   return;
                                            // }
                                            // _groupQuestionController.changeStatus(
                                            //     widget.index, value);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '- ' + formatMoney(_.usePoint),
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7.sp,
                          ),
                          GetBuilder<PaymentController>(
                              init: paymentController,
                              builder: (_) =>
                                  widgetMoney('T???ng thanh to??n:', _.total)),
                        ],
                      ),
                    ),
                    DefaultButton(
                      btnText: '?????ng ??',
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              );
                            },
                            barrierColor: Color(0x80000000),
                            barrierDismissible: false);
                        discountController.createOrder(
                            widget.list, widget.isBuyNow);
                      },
                    )
                  ],
                ),
              ),
            )));
  }

  Row widgetMoney(String title, double value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: TextStyle(
              // color: colorTitle,
              fontSize: title == 'T???ng thanh to??n:' ? 15.sp : 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            title == 'T???ng voucher gi???m gi??:'
                ? '-' + formatMoney(value)
                : formatMoney(value),
            style: TextStyle(
              color:
                  title == 'T???ng thanh to??n:' ? Colors.orange : Colors.black87,
              fontSize: title == 'T???ng thanh to??n:' ? 14.sp : 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
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
              child: Image.network(
                cartModel.image[0],
                fit: BoxFit.cover,
                height: 70.sp,
                width: 70.sp,
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
