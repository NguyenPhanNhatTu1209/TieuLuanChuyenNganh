import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/pages/cart/widgets/cart_item_button.dart';
import 'package:freshfood/src/pages/products/controllers/product_controller.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sizer/sizer.dart';

class BottomNavigationProduct extends StatelessWidget {
  ProductDetailController productController;
  BottomNavigationProduct({this.productController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14.w,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, -10),
          blurRadius: 35,
          color: kPrimaryColor.withOpacity(0.38),
        )
      ]),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    // padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {},
                    icon: Icon(
                      PhosphorIcons.messenger_logo,
                      color: Color(0xFF2C3D50),
                      size: 8.w,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      left: BorderSide(width: 0.5.w, color: Colors.grey),
                    )
                        // borderRadius: BorderRadius.circular(20)),
                        ),
                    child: IconButton(
                      // padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        bottomSheet(context, "Thêm vào giỏ hàng", () {
                          productController.addToCart();
                          Navigator.pop(context);
                        });
                      },
                      icon: Icon(
                        CupertinoIcons.cart_badge_plus,
                        color: Color(0xFF2C3D50),
                        size: 8.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 14.w,
              margin: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                border: Border.all(width: 3.w, color: kPrimaryColor),
                // borderRadius: BorderRadius.circular(20)),
              ),
              child: InkWell(
                splashColor: kPrimaryColor,
                onTap: () {
                  bottomSheet(context, "Mua ngay", () {
                    List<CartModel> temp = [];
                    temp.add(CartModel.fromMap(
                        productController.product.toMapCart()));
                    Get.toNamed(Routes.DETAIL_PAYMENT,
                        arguments: {"list": temp, "isBuyNow": true});
                  });
                },
                child: Container(
                  child: Text(
                    'Mua ngay',
                    style: TextStyle(
                      fontSize: 6.w,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> bottomSheet(
      BuildContext context, String text, Function onpress) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 90.w,
          child: Container(
            // decoration: new BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: new BorderRadius.only(
            //         topLeft: const Radius.circular(10.0),
            //         topRight: const Radius.circular(10.0))),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 5.w,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(10),
                        //   topRight: Radius.circular(10),
                        // ),
                        child: CachedNetworkImage(
                          imageUrl: productController.product.image[0],
                          fit: BoxFit.fill,
                          height: 43.2.w,
                          width: 50.w,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(children: [
                        SizedBox(
                          height: 5.w,
                        ),
                        Text(
                          formatMoney(productController.product.price),
                          style: TextStyle(
                            fontSize: 6.w,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 2.w,
                        ),
                        Text(
                          'Kho : ${productController.product.quantity}',
                          style: TextStyle(
                            fontSize: 4.w,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.w,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.only(left: 7.w),
                        child: Text(
                          'Số lượng:',
                          style: TextStyle(
                            fontSize: 5.w,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Row(
                          children: [
                            CartItemButton(PhosphorIcons.minus, () {
                              productController.decreaseQuantity();
                              // widget.cartController.decreaseQuantity(widget.index);

                              // setState(() {
                              //   widget.cart.decrementQuantity();
                              //   widget.cartController.getTotalMoney();
                              // });
                            }),
                            SizedBox(width: 1.w),
                            GetBuilder<ProductDetailController>(
                              init: productController,
                              builder: (_) => Text(
                                productController.product.number.toString(),
                                style: TextStyle(
                                  fontSize: 4.w,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            // GetBuilder<CartController>(
                            //   init: widget.cartController,
                            //   builder: (_) => Text(
                            //     _.listProductCart[widget.index]['quantity']
                            //         .toString(),
                            //     style: TextStyle(
                            //       fontSize: 4.w,
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(width: 1.w),
                            CartItemButton(PhosphorIcons.plus, () {
                              productController.increaseQuantity();

                              // widget.cartController.increaseQuantity(widget.index);
                              // setState(() {
                              //   widget.cart.incrementQuantity();
                              //   widget.cartController.getTotalMoney();
                              // });
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.w,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // padding: EdgeInsets.all(2.w),
                    width: 90.w,
                    margin: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      border: Border.all(width: 3.w, color: kPrimaryColor),
                      // borderRadius: BorderRadius.circular(20)),
                    ),
                    child: InkWell(
                      splashColor: kPrimaryColor,
                      onTap: () {
                        onpress();
                      },
                      child: Container(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 6.w,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
