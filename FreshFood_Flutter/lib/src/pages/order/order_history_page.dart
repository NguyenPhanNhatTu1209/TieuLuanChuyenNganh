import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/history.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/public/constant.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OrderHistoryPage extends StatefulWidget {
  final List<HistoryModel> history;
  final String orderCode;
  OrderHistoryPage({this.history, this.orderCode});
  @override
  State<StatefulWidget> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: Container(
          width: 70.w,
          child: Drawer(
            child: DrawerLayout(),
          ),
        ),
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
          title: Text(
            "Lịch sử đơn hàng",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Container(
          height: 100.h,
          width: 100.w,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.only(top: 15.sp, left: 17.sp, bottom: 10.sp),
                  child: Row(children: [
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      'Mã đơn hàng',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 110.sp,
                    ),
                    Text(
                      widget.orderCode,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]),
                ),
                // cart image
                Container(
                  padding: EdgeInsets.only(top: 10.sp, left: 17.sp),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.truck_bold,
                        color: Colors.black,
                        size: 23.sp,
                      ),
                      SizedBox(
                        width: 20.sp,
                      ),
                      Text("Thông tin vận chuyển:",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.sp, left: 17.sp),
                  height: 150.w,
                  // width: 100.sp,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.history.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        WidgetHistoryOrder(
                          historyModel: widget.history[index],
                        ),
                      ]);
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class WidgetHistoryOrder extends StatelessWidget {
  HistoryModel historyModel;
  WidgetHistoryOrder({Key key, this.historyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.sp, bottom: 20.sp),
      child: Row(children: [
        Container(
          width: 50.sp,
          height: 30.sp,
          child: Text(
              "${historyModel.createdAt.toLocal().day} Th${historyModel.createdAt.toLocal().month} ${historyModel.createdAt.toLocal().hour}:${historyModel.createdAt.toLocal().minute}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
        ),
        SizedBox(
          width: 10.sp,
        ),
        Icon(
          Icons.arrow_circle_down,
          color: Colors.green,
          size: 25.sp,
        ),
        SizedBox(
          width: 10.sp,
        ),
        Container(
          width: 165.sp,
          child: Text(" ${historyModel.title}",
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400)),
        )
      ]),
    );
  }
}
