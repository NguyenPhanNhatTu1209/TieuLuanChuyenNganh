import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/models/eveluate.dart';
import 'package:freshfood/src/models/order.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/order/controller/order_controller.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/repository/order_repository.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FirstPage extends StatefulWidget {
  final List<OrderModel> orders;
  String status;
  FirstPage({this.orders, this.status});

  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListView.builder(
        controller: scrollController,
        itemCount: widget.orders.length,
        itemBuilder: (context, index) {
          return Column(children: [
            WidgetOrder(
              order: widget.orders[index],
              status: widget.status,
            ),
          ]);
        },
      ),
      // Column(
      //   children: [

      //     pageDetailOrder(widget: widget, orders: widget.orders),
      //   ],
      // ),
    );
  }
}

class WidgetOrder extends StatelessWidget {
  OrderModel order;
  String status;
  WidgetOrder({this.order, this.status});
  final orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.sp),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20.sp),
            child: Column(
              children: [
                Material(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_ORDER,
                          arguments: {"order": order});

                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.sp,
                        ),
                        Image.network(
                          order.product[0].image[0],
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
                                  "[${order.orderCode}] ${order.product[0].name}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding:
                                    EdgeInsets.only(top: 5.sp, right: 5.sp),
                                child: Text(
                                  "x${order.product[0].quantity}",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding:
                                    EdgeInsets.only(top: 5.sp, right: 5.sp),
                                child: Text(
                                  formatMoney(order.product[0].price),
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
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.sp),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                    top: BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                  )),
                  padding:
                      EdgeInsets.only(top: 5.sp, left: 10.sp, bottom: 5.sp),
                  child: Row(
                    children: [
                      Text("${order.product.length} sản phẩm",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w300)),
                      SizedBox(
                        width: 42.sp,
                      ),
                      Icon(
                        PhosphorIcons.money,
                        size: 28,
                        color: Colors.green,
                      ),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Text("Thành tiền:",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 3.sp,
                      ),
                      Text(
                        formatMoney(order.totalMoney),
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.sp),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                  )),
                  padding:
                      EdgeInsets.only(top: 5.sp, left: 10.sp, bottom: 5.sp),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.HISTORY_ORDER, arguments: {
                          "history": order.history,
                          "orderCode": order.orderCode
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.truck,
                            size: 28,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(status,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                ),
                                Icon(PhosphorIcons.caret_right)
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 3.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          status == "Chờ xác nhận"
              ? Row(
                  children: [
                    SizedBox(
                      height: 5.sp,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 160.sp, right: 20.sp),
                      child: FlatButton(
                        height: 35.sp,
                        minWidth: 120.sp,
                        padding: EdgeInsets.symmetric(vertical: 3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          OrderRepository()
                              .changeStatusOrderByAdminOrStaff(
                                  id: order.id, status: 4)
                              .then((value) {
                            if (value == true) {
                              GetSnackBar getSnackBar = GetSnackBar(
                                title: 'Hủy đơn hàng thành công',
                                subTitle:
                                    'Đơn hàng đã chuyển sang trạng thái đã hủy',
                              );
                              getSnackBar.show();
                              orderController.getOrder(
                                  search: '', limit: 10, skip: 1);
                            } else {
                              GetSnackBar getSnackBar = GetSnackBar(
                                title: 'Hủy đơn hàng thất bại',
                                subTitle: '',
                              );
                              getSnackBar.show();
                            }
                          });
                        },
                        child: Text("Hủy"),
                      ),
                    ),
                  ],
                )
              : status == "Đang giao"
                  ? Row(
                      children: [
                        SizedBox(
                          height: 5.sp,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 160.sp, right: 20.sp),
                          child: FlatButton(
                            height: 35.sp,
                            minWidth: 120.sp,
                            padding: EdgeInsets.symmetric(vertical: 3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: kPrimaryColor,
                            textColor: Colors.white,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              OrderRepository()
                                  .changeStatusOrderByAdminOrStaff(
                                      id: order.id, status: 3)
                                  .then((value) {
                                if (value == true) {
                                  GetSnackBar getSnackBar = GetSnackBar(
                                    title:
                                        'Chuyển trạng thái đơn hàng thành công',
                                    subTitle:
                                        'Đã chuyển trạng thái thành "Đã giao"',
                                  );
                                  getSnackBar.show();
                                  orderController.getOrder(
                                      search: '', limit: 10, skip: 1);
                                } else {
                                  GetSnackBar getSnackBar = GetSnackBar(
                                    title:
                                        'Chuyển trạng thái đơn hàng thất bại',
                                    subTitle: '',
                                  );
                                  getSnackBar.show();
                                }
                              });
                            },
                            child: Text("Đã nhận"),
                          ),
                        ),
                      ],
                    )
                  : status == "Đã giao" || status == "Đã hủy"
                      ? SizedBox(
                          height: 5.sp,
                        )
                      : SizedBox(),
          status == "Đã giao" && order.checkEveluate == false
              ? Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                      child: FlatButton(
                        height: 35.sp,
                        minWidth: 120.sp,
                        padding: EdgeInsets.symmetric(vertical: 3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          List<CartModel> product = [];
                          product.addAll((order.product
                              .map((e) => CartModel.fromMapCart(e.toMap()))
                              .toList()));
                          Get.toNamed(Routes.DETAIL_PAYMENT,
                              arguments: {"list": product});
                        },
                        child: Text("Mua lại"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20.sp),
                      child: FlatButton(
                        height: 35.sp,
                        minWidth: 120.sp,
                        padding: EdgeInsets.symmetric(vertical: 3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          List<EveluateModel> product = [];
                          product.addAll((order.product
                              .map((e) => EveluateModel.fromMap1(e.toMap()))
                              .toList()));
                          product.forEach((element) {
                            element.orderId = order.id;
                          });
                          Get.toNamed(Routes.EVELUATE_PRODUCT,
                              arguments: {"listProduct": product});
                          // arguments: {"list": product});
                        },
                        child: Text("Đánh giá"),
                      ),
                    )
                  ],
                )
              : status == "Đã hủy"
                  ? Container(
                      padding: EdgeInsets.only(left: 140.sp),
                      child: FlatButton(
                        height: 35.sp,
                        minWidth: 120.sp,
                        padding: EdgeInsets.symmetric(vertical: 3),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          List<CartModel> product = [];
                          product.addAll((order.product
                              .map((e) => CartModel.fromMapCart(e.toMap()))
                              .toList()));
                          Get.toNamed(Routes.DETAIL_PAYMENT,
                              arguments: {"list": product});
                        },
                        child: Text("Mua lại"),
                      ),
                    )
                  : status == "Đã giao" && order.checkEveluate == true
                      ? Container(
                          padding: EdgeInsets.only(left: 140.sp),
                          child: FlatButton(
                            height: 35.sp,
                            minWidth: 120.sp,
                            padding: EdgeInsets.symmetric(vertical: 3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: kPrimaryColor,
                            textColor: Colors.white,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              List<CartModel> product = [];
                              product.addAll((order.product
                                  .map((e) => CartModel.fromMapCart(e.toMap()))
                                  .toList()));
                              Get.toNamed(Routes.DETAIL_PAYMENT,
                                  arguments: {"list": product});
                            },
                            child: Text("Mua lại"),
                          ),
                        )
                      : Container(),
        ],
      ),
    );
  }
}
