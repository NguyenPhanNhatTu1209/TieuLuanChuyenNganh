import 'package:flutter/material.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/discount.dart';
import 'package:freshfood/src/pages/cart/widgets/product_image.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DiscountItem extends StatefulWidget {
  DiscountModel discount;
  DiscountItem({this.discount});
  @override
  State<StatefulWidget> createState() {
    return _DiscountItem();
  }
}

class _DiscountItem extends State<DiscountItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed(Routes.UPDATE_PRODUCT,
        //     arguments: {"productCurrent": widget.product});
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
                'https://img.timviec.com.vn/2020/08/voucher-la-gi-4.jpg?fbclid=IwAR2b0RjRjzwLKxjnqymd-A4UKRJ_b6TTD1CjP4xM7oVmm5-WTkkWe2C80uo',
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
                      'Giảm ${widget.discount.percentDiscount}%',
                      style: TextStyle(
                        fontSize: 5.w,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3.w),
                    Text(
                      'Đơn tối thiểu ' +
                          formatMoney(
                              widget.discount.minimumDiscount.toDouble()) +
                          ' Giảm tối đa ' +
                          formatMoney(widget.discount.maxDiscount.toDouble()),
                      style: TextStyle(
                        fontSize: 3.5.w,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    LinearProgressIndicator(
                      value: widget.discount.quantity > 50
                          ? 0
                          : (50 - widget.discount.quantity) / 50,
                      semanticsLabel: 'Linear progress indicator',
                      color: Colors.green,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    Text(
                      "Còn lại: " + widget.discount.quantity.toString(),
                      style: TextStyle(
                        fontSize: 3.5.w,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    Row(
                      children: [
                        Text(
                          "Hết hạn: " +
                              DateFormat("dd-MM-yyyy")
                                  .format(widget.discount.duration.toLocal())
                                  .toString(),
                          style: TextStyle(
                            fontSize: 3.5.w,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text(
                        //   widget.product.sold.toString(),
                        //   style: TextStyle(
                        //     fontSize: 4.w,
                        //     color: Colors.red,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
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
