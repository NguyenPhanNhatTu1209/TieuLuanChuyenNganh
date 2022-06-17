import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/pages/inventory/widget/create_inventory_history_item%20.dart';
import 'package:freshfood/src/pages/inventory/widget/detail_inventory_history_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'controllers/inventory_history_controller.dart';

class CreateInventoryHistoryPage extends StatefulWidget {
  @override
  _CreateInventoryHistoryPageState createState() =>
      _CreateInventoryHistoryPageState();
}

class _CreateInventoryHistoryPageState
    extends State<CreateInventoryHistoryPage> {
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _inventoryHistoryController = Get.put(InventoryHistoryController());
  String _search = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inventoryHistoryController.initCreateInventory();
    _inventoryHistoryController.getProduct(search: _search);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          _inventoryHistoryController.getProduct(search: _search);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
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
            actions: [
              IconButton(
                onPressed: () =>
                    _inventoryHistoryController.createInventoryHistory(context),
                icon: Icon(
                  PhosphorIcons.check,
                  color: Colors.white,
                  size: 7.w,
                ),
              ),
            ],
            title: Text(
              'Tạo phiếu nhập kho',
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
                Padding(
                  padding: EdgeInsets.only(top: 5.sp, left: 5.sp, right: 5.sp),
                  child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm",
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: EdgeInsets.all(8),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                BorderSide(color: Colors.grey.shade100)),
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        _search = value;
                        _inventoryHistoryController.initFindInventory();
                        _inventoryHistoryController.getProduct(search: _search);
                      }),
                ),
                Expanded(
                  child: Container(
                    child: GetBuilder<InventoryHistoryController>(
                      init: _inventoryHistoryController,
                      builder: (_) => ListView.builder(
                        controller: scrollController,
                        itemCount: _.listProduct.length,
                        itemBuilder: (context, index) {
                          return CreateInventoryHistoryItem(
                            product: _.listProduct[index],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
