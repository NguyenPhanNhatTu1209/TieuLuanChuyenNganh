import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/pages/cart/widgets/cart_item_button.dart';
import 'package:freshfood/src/pages/cart/widgets/product_image.dart';
import 'package:freshfood/src/pages/inventory/controllers/inventory_history_controller.dart';
import 'package:freshfood/src/pages/question/controllers/group_question_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CreateInventoryHistoryItem extends StatefulWidget {
  dynamic product;
  CreateInventoryHistoryItem({this.product});
  @override
  State<StatefulWidget> createState() {
    return _CreateInventoryHistoryItemState();
  }
}

class _CreateInventoryHistoryItemState
    extends State<CreateInventoryHistoryItem> {
  bool isMain = false;
  TextEditingController priceController = TextEditingController();
  TextEditingController priceDiscountController = TextEditingController();
  final _inventoryHistoryController = Get.put(InventoryHistoryController());

  @override
  void initState() {
    super.initState();
    priceController.text = widget.product['price'].toString();
    priceDiscountController.text = widget.product['priceDiscount'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ProductImage(
                widget.product['image'][0],
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
                      widget.product['name'],
                      style: TextStyle(
                        fontSize: 5.w,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 1.w),
                    Row(
                      children: [
                        Text(
                          'Số lượng: ',
                          style: TextStyle(
                            fontSize: 4.w,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        CartItemButton(PhosphorIcons.minus, () {
                          _inventoryHistoryController.updateQuantity(
                              widget.product['_id'], false);
                        }),
                        Text(
                          widget.product['quantityChange'].toString(),
                          style: TextStyle(
                            fontSize: 4.w,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        CartItemButton(PhosphorIcons.plus, () {
                          _inventoryHistoryController.updateQuantity(
                              widget.product['_id'], true);
                        }),
                      ],
                    ),
                    SizedBox(height: 1.w),
                    Row(
                      children: [
                        Text(
                          'Giá gốc: ',
                          style: TextStyle(
                            fontSize: 4.w,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          width: 20.w,
                          child: TextField(
                            controller: priceController,
                            onChanged: (v) {
                              _inventoryHistoryController.changePrice(
                                  widget.product['_id'], v, false);
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.w),
                    Row(
                      children: [
                        Text(
                          'Giảm còn: ',
                          style: TextStyle(
                            fontSize: 5.w,
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          width: 20.w,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 5.w,
                              color: Colors.green,
                              fontWeight: FontWeight.w400,
                            ),
                            controller: priceDiscountController,
                            onChanged: (v) {
                              _inventoryHistoryController.changePrice(
                                  widget.product['_id'], v, true);
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
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
