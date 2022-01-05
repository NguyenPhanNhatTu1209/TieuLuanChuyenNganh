import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/cart/controller/cart_controller.dart';
import 'package:freshfood/src/pages/cart/widgets/cart_item_button.dart';
import 'package:freshfood/src/pages/cart/widgets/product_image.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProductItem extends StatefulWidget {
  ProductModel product;
  ProductItem({this.product});
  @override
  State<StatefulWidget> createState() {
    return _ProductItem();
  }
}

class _ProductItem extends State<ProductItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.UPDATE_PRODUCT,
            arguments: {"productCurrent": widget.product});
      },
      splashColor: Colors.grey,
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ProductImage(
                widget.product.image[0],
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
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 5.w,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3.w),
                    Row(
                      children: <Widget>[
                        Text(
                          formatMoney(widget.product.price),
                          style: TextStyle(
                            fontSize: 5.w,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    Row(
                      children: [
                        Text(
                          "Số lượng sản phẩm còn ",
                          style: TextStyle(
                            fontSize: 4.w,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.product.quantity.toString(),
                          style: TextStyle(
                            fontSize: 4.w,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    Row(
                      children: [
                        Text(
                          "Số lượng sản phẩm đã bán ",
                          style: TextStyle(
                            fontSize: 3.5.w,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.product.sold.toString(),
                          style: TextStyle(
                            fontSize: 4.w,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.w),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: Colors.grey)
        ]),
      ),
    );
  }
}
