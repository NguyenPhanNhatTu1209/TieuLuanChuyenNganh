import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/lang/vi_VN.dart';
import 'package:freshfood/src/models/eveluate.dart';
import 'package:freshfood/src/models/order.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/models/product_order_model.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/order_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import 'controller/order_controller.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderModel order;
  OrderDetailPage({this.order});
  @override
  State<StatefulWidget> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  final orderController = Get.put(OrderController());

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
              size: 8.w,
            ),
          ),
          title: Text(
            "Thông tin đơn hàng",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.teal[300],
                  margin: EdgeInsets.only(
                    bottom: 15.0,
                  ),
                  child: Row(children: [
                    Column(children: [
                      SizedBox(
                        height: 10.sp,
                      ),
                      Text(
                        'Đơn hàng đã hoàn thành',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Container(
                        height: 60.sp,
                        width: 200.sp,
                        padding: EdgeInsets.only(left: 30.sp),
                        child: Text(
                          'Cảm ơn bạn đã lựa chọn FreshFood. Chúc bạn một ngày tốt lành và nhớ đánh giá nhé!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]),
                    SizedBox(
                      width: 30.sp,
                    ),
                    Container(
                      child: Icon(
                        Icons.checklist_outlined,
                        size: 40.sp,
                        color: Colors.white,
                      ),
                    )
                  ]),
                ),
                // cart image
                Container(
                  padding: EdgeInsets.only(top: 5.sp, left: 17.sp),
                  child: Row(
                    children: [
                      Icon(PhosphorIcons.truck),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(widget.order.history.last.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.HISTORY_ORDER, arguments: {
                              "history": widget.order.history,
                              "orderCode": widget.order.orderCode
                            });
                          },
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(fontSize: 14.sp),
                          ),
                          child: Container(
                            child: Text(
                              'Xem',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(
                    top: 25.0,
                    bottom: 12.0,
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
                      child: Text(
                        'Địa chỉ nhận hàng',
                        style: TextStyle(
                          // color: colorTitle,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(children: [
                    SizedBox(
                      width: 35.sp,
                    ),
                    Column(children: [
                      Container(
                        width: 210.sp,
                        child: Text(
                          widget.order.area.name,
                          style: TextStyle(
                            // color: colorTitle,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        width: 210.sp,
                        child: Text(
                          widget.order.area.phone,
                          style: TextStyle(
                            // color: colorTitle,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        width: 210.sp,
                        child: Text(
                          '${widget.order.area.address} - ${widget.order.area.district} - ${widget.order.area.province}',
                          style: TextStyle(
                            // color: colorTitle,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ]),
                  ]),
                ),
                Container(
                    height: widget.order.product.length * 80.sp,
                    padding: EdgeInsets.only(left: 10.sp, right: 10.sp),
                    margin: EdgeInsets.only(
                      top: 25.0,
                    ),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(), // new
                      controller: scrollController,
                      itemCount: widget.order.product.length,
                      itemBuilder: (context, index) {
                        return ProductWidget(
                          product: widget.order.product[index],
                        );
                      },
                    )),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Tổng tiền sản phẩm:',
                            style: TextStyle(
                              // color: colorTitle,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 76.sp,
                          ),
                          Container(
                            child: Text(
                              formatMoney(widget.order.totalMoneyProduct),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Giá ship:',
                            style: TextStyle(
                              // color: colorTitle,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 143.sp,
                          ),
                          Container(
                            child: Text(
                              formatMoney(widget.order.shipFee),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      widget.order.discountMoney == null ||
                              widget.order.discountMoney == 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Text(
                                  'Giảm giá: ',
                                  style: TextStyle(
                                    // color: colorTitle,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 132.sp,
                                ),
                                Container(
                                  child: Text(
                                    '-' +
                                        formatMoney(widget.order.discountMoney),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      widget.order.bonusMoney == null ||
                              widget.order.bonusMoney == 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Text(
                                  'Xu sử dụng: ',
                                  style: TextStyle(
                                    // color: colorTitle,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 118.sp,
                                ),
                                Container(
                                  child: Text(
                                    '-' + formatMoney(widget.order.bonusMoney),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 5.sp),
                      Row(
                        children: [
                          Text(
                            'Thành Tiền:',
                            style: TextStyle(
                              // color: colorTitle,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 125.sp,
                          ),
                          Container(
                            child: Text(
                              formatMoney(widget.order.totalMoney),
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  margin: EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.wallet_bold,
                        size: 20.sp,
                        color: Colors.redAccent,
                      ),
                      SizedBox(width: 5.sp),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(right: 20.sp),
                          child: Text(
                            widget.order.typePayment == "Chưa thanh toán"
                                ? widget.order.typePayment
                                : 'Phương thức thanh toán: ${widget.order.typePayment}',
                            style: TextStyle(
                              // color: colorTitle,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10.sp),
                  margin: EdgeInsets.only(
                    bottom: 12.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Mã Đơn Hàng:',
                            style: TextStyle(
                              // color: colorTitle,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: 20.sp),
                              child: Text(
                                widget.order.orderCode,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  // color: colorTitle,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(
                        children: [
                          Text(
                            'Thời gian đặt hàng:',
                            style: TextStyle(
                              // color: colorTitle,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(right: 20.sp),
                              child: Text(
                                DateFormat("dd-MM-yyyy HH:mm:ss")
                                    .format(widget.order.createdAt.toLocal())
                                    .toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  // color: colorTitle,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      widget.order.typePayment == "Chưa thanh toán" ||
                              widget.order.typePayment == "COD"
                          ? Container()
                          : Row(
                              children: [
                                Text(
                                  'Thời gian thanh toán:',
                                  style: TextStyle(
                                    // color: colorTitle,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 20.sp),
                                    child: Text(
                                      DateFormat("dd-MM-yyyy HH:mm:ss")
                                          .format(
                                              widget.order.updatedAt.toLocal())
                                          .toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        // color: colorTitle,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                ),
                orderController.getStatus(
                            widget.order.status, widget.order.checkEveluate) !=
                        ''
                    ? DefaultButton(
                        btnText: orderController.getStatus(
                            widget.order.status, widget.order.checkEveluate),
                        onPressed: () {
                          if (widget.order.status == 3) {
                            List<EveluateModel> product = [];
                            product.addAll((widget.order.product
                                .map((e) => EveluateModel.fromMap1(e.toMap()))
                                .toList()));
                            product.forEach((element) {
                              element.orderId = widget.order.id;
                            });
                            Get.toNamed(Routes.EVELUATE_PRODUCT,
                                arguments: {"listProduct": product});
                            // arguments: {"list": product});
                          } else {
                            OrderRepository()
                                .changeStatusOrderByAdminOrStaff(
                                    id: widget.order.id,
                                    status: widget.order.status + 1)
                                .then((value) {
                              if (value == true) {
                                GetSnackBar getSnackBar = GetSnackBar(
                                  title:
                                      'Chuyển trạng thái đơn hàng thành công',
                                  subTitle:
                                      'Đã chuyển trạng thái thành "Đã giao"',
                                );
                                Get.back();

                                getSnackBar.show();
                                userProvider.user.role == 0
                                    ? orderController.getOrder(
                                        search: '', limit: 10, skip: 1)
                                    : orderController.getOrderByAdmin(
                                        search: '', limit: 10, skip: 1);
                              } else {
                                GetSnackBar getSnackBar = GetSnackBar(
                                  title: 'Chuyển trạng thái đơn hàng thất bại',
                                  subTitle: '',
                                );
                                getSnackBar.show();
                              }
                            });
                          }
                        },
                      )
                    : Container()
              ],
            ),
          ),
        ));
  }
}

class ProductWidget extends StatelessWidget {
  ProductOrderModel product;
  ProductWidget({this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 5.sp),
        margin: EdgeInsets.only(bottom: 10.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              //                   <--- left side
              color: Colors.black26,
              width: 1.sp,
            ),
          ),
        ),
        height: 70.sp,
        child: Material(
            child: InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    SizedBox(
                      width: 10.sp,
                    ),
                    Image.network(
                      product.image[0],
                      fit: BoxFit.cover,
                      height: 70.sp,
                      width: 70.sp,
                    ),
                    SizedBox(
                      width: 20.sp,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 5.sp),
                            child: Text(
                              "${product.name}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 5.sp, right: 5.sp),
                            child: Text(
                              "x${product.quantity}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 5.sp, right: 5.sp),
                            child: Text(
                              formatMoney(product.price),
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
                    Icon(PhosphorIcons.caret_right),
                  ],
                ))));
  }
}
