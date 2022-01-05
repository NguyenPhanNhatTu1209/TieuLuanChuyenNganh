import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/order.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/order/controller/order_controller.dart';
import 'package:freshfood/src/pages/order/pages/first_page.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:flutter_svg/avd.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();
  final orderController = Get.put(OrderController());

  List<Widget> _pages = [
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];
  List<OrderModel> listOrder = [OrderModel()];
  List<String> statusOrder = [
    "Chờ xác nhận",
    "Đã xác nhận",
    "Đang giao",
    "Đã giao",
    "Đã hủy"
  ];
  int selectedStatus = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      vsync: this,
      length: statusOrder.length,
      initialIndex: 0,
    );
    orderController.initController();
    orderController.getOrder(search: '', limit: 10, skip: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            PhosphorIcons.arrow_left,
            color: Colors.white,
            size: 8.w,
          ),
        ),
        title: Container(
          padding: EdgeInsets.only(
            left: 5.sp,
          ),
          child: Text(
            "Đơn Hàng",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => {Get.toNamed(Routes.CHAT)},
            icon: Icon(
              PhosphorIcons.messenger_logo,
              size: 7.w,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.sp, left: 5.sp, right: 5.sp),
            child: TextField(
                decoration: InputDecoration(
                  hintText: "Tìm kiếm nhập tên sản phẩm",
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
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  orderController.getOrder(search: value, limit: 10, skip: 1);
                }),
          ),
          Container(
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              labelColor: kPrimaryColor,
              indicatorColor: Colors.green[600],
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
              tabs: [
                Container(
                  width: 25.w,
                  child: Tab(
                    text: statusOrder[0],
                  ),
                ),
                Container(
                  width: 25.w,
                  child: Tab(
                    text: statusOrder[1],
                  ),
                ),
                Container(
                  width: 20.w,
                  child: Tab(
                    text: statusOrder[2],
                  ),
                ),
                Container(
                  width: 15.w,
                  child: Tab(
                    text: statusOrder[3],
                  ),
                ),
                Container(
                  width: 15.w,
                  child: Tab(
                    text: statusOrder[4],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder(
              init: orderController,
              builder: (_) => TabBarView(
                controller: _tabController,
                children: [
                  FirstPage(
                      orders: orderController.list0, status: statusOrder[0]),
                  FirstPage(
                      orders: orderController.list1, status: statusOrder[1]),
                  FirstPage(
                      orders: orderController.list2, status: statusOrder[2]),
                  FirstPage(
                      orders: orderController.list3, status: statusOrder[3]),
                  FirstPage(
                      orders: orderController.list4, status: statusOrder[4]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
