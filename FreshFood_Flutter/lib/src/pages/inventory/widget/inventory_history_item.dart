import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshfood/src/pages/cart/widgets/product_image.dart';
import 'package:freshfood/src/pages/question/controllers/group_question_controller.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class InventoryHistoryItem extends StatefulWidget {
  dynamic inventoryHistory;
  int index;
  InventoryHistoryItem({this.inventoryHistory, this.index});
  @override
  State<StatefulWidget> createState() {
    return _InventoryHistoryItemState();
  }
}

class _InventoryHistoryItemState extends State<InventoryHistoryItem> {
  bool isMain = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.DETAIL_MANAGER_INVENTORY_HISTORY,
            arguments: {"inventoryHistory": widget.inventoryHistory});
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
                'https://static.helpjuice.com/helpjuice_production/uploads/upload/image/4752/direct/1597678311691-Explicit%20Knowledge.jpg',
                height: 10.w,
                width: 10.w,
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
                      'Phiếu nhập/xuất kho',
                      style: TextStyle(
                        fontSize: 5.w,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat("hh:mm a")
                          .format(DateTime.parse(
                                  widget.inventoryHistory['createdAt'])
                              .toLocal())
                          .toString(),
                      style: TextStyle(
                        fontSize: 4.w,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      DateFormat("dd-MM-yyyy")
                          .format(DateTime.parse(
                                  widget.inventoryHistory['createdAt'])
                              .toLocal())
                          .toString(),
                      style: TextStyle(
                        fontSize: 4.w,
                        color: Colors.black,
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
