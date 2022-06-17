import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freshfood/src/pages/Admin/widget/drawer_layout_admin.dart';
import 'package:freshfood/src/pages/inventory/widget/inventory_history_item.dart';
import 'package:freshfood/src/pages/question/widget/dialog_group_question.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'controllers/inventory_history_controller.dart';

class ManagerInventoryHistory extends StatefulWidget {
  @override
  _ManagerInventoryHistoryState createState() =>
      _ManagerInventoryHistoryState();
}

class _ManagerInventoryHistoryState extends State<ManagerInventoryHistory> {
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
        drawer: Container(
          width: 70.w,
          child: Drawer(
            child: DrawerLayoutAdmin(status: 6),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            icon: SvgPicture.asset("assets/icons/menu.svg"),
          ),
          title: Text(
            'Quản lý phiếu nhập kho',
            style: TextStyle(
              color: Colors.white,
              fontSize: _size.width / 20.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.CREATE_INVENTORY_HISTORY);
              },
              icon: Icon(
                PhosphorIcons.plus,
                size: 7.w,
              ),
            ),
          ],
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
                      itemCount: _.listImportInventory.length,
                      itemBuilder: (context, index) {
                        return InventoryHistoryItem(
                          inventoryHistory: _.listImportInventory[index],
                          index: index,
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
