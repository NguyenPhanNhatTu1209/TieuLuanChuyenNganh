import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/pages/cart/controller/cart_controller.dart';
import 'package:freshfood/src/pages/cart/widgets/cart_item_button.dart';
import 'package:freshfood/src/pages/cart/widgets/product_image.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CartItem extends StatefulWidget {
  CartModel cart;
  CartController cartController;
  List<CartModel> listCart;
  int index;
  CartItem({this.cart, this.cartController, this.index, this.listCart});
  @override
  State<StatefulWidget> createState() {
    return _CartItem();
  }
}

class _CartItem extends State<CartItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartController = widget.cartController;

    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GetBuilder<CartController>(
              init: widget.cartController,
              builder: (_) => IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: (_.listProductCart[widget.index]['selected'] == 1)
                    ? Icon(
                        Icons.check_box_rounded,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.check_box_outline_blank_outlined,
                        color: Colors.green,
                      ),
                onPressed: () {
                  widget.cartController.changeStatusItem(widget.index);
                },
              ),
            ),
            // IconButton(
            //   padding: EdgeInsets.zero,
            //   constraints: BoxConstraints(),
            //   icon: (widget.cart.status == 0)
            //       ? Icon(
            //           Icons.check_box_outline_blank_outlined,
            //           color: Colors.green,
            //         )
            //       : Icon(
            //           Icons.check_box_rounded,
            //           color: Colors.green,
            //         ),
            //   onPressed: () {
            //     setState(() {
            //       if (widget.cart.status == 1)
            //         widget.cart.status = 0;
            //       else
            //         widget.cart.status = 1;
            //       widget.cartController.changeStatusItem(widget.index);
            //       widget.cartController.getTotalMoney();
            //     });
            //   },
            // ),
            ProductImage(
              widget.cart.image[0],
              height: 30.w,
              width: 30.w,
              padding: 3.w,
            ),
            // SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.cart.name,
                    style: TextStyle(
                      fontSize: 5.w,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.w),
                  Row(
                    children: <Widget>[
                      Text(
                        formatMoney(widget.cart.cost),
                        style: TextStyle(
                          fontSize: 5.w,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.w),
                  Row(
                    children: <Widget>[
                      CartItemButton(PhosphorIcons.minus, () {
                        widget.cartController.decreaseQuantity(widget.index);
                      }),
                      SizedBox(width: 1.w),

                      SizedBox(width: 1.w),
                      GetBuilder<CartController>(
                        init: widget.cartController,
                        builder: (_) => Text(
                          _.listProductCart[widget.index]['quantity']
                              .toString(),
                          style: TextStyle(
                            fontSize: 4.w,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 1.w),
                      CartItemButton(PhosphorIcons.plus, () {
                        widget.cartController.increaseQuantity(widget.index);
                      }),
                      // CartItemButton(
                      //     PhosphorIcons.trash, () => cartController.deleteItem(this.cartItem)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(color: Colors.grey)
      ]),
    );
  }
}
