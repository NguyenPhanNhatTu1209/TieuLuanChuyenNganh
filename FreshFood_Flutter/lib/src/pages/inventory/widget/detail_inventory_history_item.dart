import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/pages/cart/widgets/product_image.dart';
import 'package:freshfood/src/pages/question/controllers/group_question_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DetailInventoryHistoryItem extends StatefulWidget {
  dynamic history;
  DetailInventoryHistoryItem({this.history});
  @override
  State<StatefulWidget> createState() {
    return _DetailInventoryHistoryItemState();
  }
}

class _DetailInventoryHistoryItemState
    extends State<DetailInventoryHistoryItem> {
  bool isMain = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed(Routes.MANAGER_QUESTION,
        //     arguments: {"idGroup": widget.groupQuestion.id});
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
                widget.history['image'],
                height: 30.w,
                width: 30.w,
                padding: 3.w,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.history['name'],
                      style: TextStyle(
                        fontSize: 5.w,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 1.w),
                    Text(
                      'Kho: ' + widget.history['quantity'].toString(),
                      style: TextStyle(
                        fontSize: 4.w,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 1.w),
                    Text(
                      formatMoney(widget.history['price'].toDouble()),
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 4.w,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 1.w),
                    Text(
                      formatMoney(widget.history['priceDiscount'].toDouble()),
                      style: TextStyle(
                        fontSize: 5.w,
                        color: Colors.green,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
