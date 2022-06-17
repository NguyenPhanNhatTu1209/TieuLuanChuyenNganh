import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freshfood/src/pages/Admin/widget/drawer_layout_admin.dart';
import 'package:freshfood/src/pages/inventory/widget/detail_inventory_history_item.dart';
import 'package:freshfood/src/pages/question/widget/dialog_group_question.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'controllers/inventory_history_controller.dart';

class DetailManagerInventoryHistory extends StatefulWidget {
  dynamic inventoryHistory;
  DetailManagerInventoryHistory({this.inventoryHistory});
  @override
  _DetailManagerInventoryHistoryState createState() =>
      _DetailManagerInventoryHistoryState();
}

class _DetailManagerInventoryHistoryState
    extends State<DetailManagerInventoryHistory> {
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _inventoryHistoryController = Get.put(InventoryHistoryController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inventoryHistoryController.initialController();
    _inventoryHistoryController.getInventoryHistory();
    // scrollController.addListener(() {
    //   if (scrollController.position.atEdge) {
    //     if (scrollController.position.pixels == 0) {
    //       // You're at the top.
    //     } else {
    //       discountController.getAllDiscount();
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: AppColors.LIGHT,
        key: _scaffoldKey,
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
            'Phiếu nhập xuất ' +
                DateFormat("dd-MM-yyyy")
                    .format(DateTime.parse(widget.inventoryHistory['createdAt'])
                        .toLocal())
                    .toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: _size.width / 20.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: GetBuilder<InventoryHistoryController>(
                    init: _inventoryHistoryController,
                    builder: (_) => ListView.builder(
                      controller: scrollController,
                      itemCount: widget.inventoryHistory['history'].length,
                      itemBuilder: (context, index) {
                        return DetailInventoryHistoryItem(
                          history: widget.inventoryHistory['history'][index],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          // bottomNavigationBar: CartTotal(),
        ));
  }
}
