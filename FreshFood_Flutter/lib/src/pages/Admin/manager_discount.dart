import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freshfood/src/models/discount.dart';
import 'package:freshfood/src/pages/Admin/widget/discount_item_host.dart';
import 'package:freshfood/src/pages/Admin/widget/drawer_layout_admin.dart';
import 'package:freshfood/src/pages/discount/controllers/discount_controlller.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ManagerDiscount extends StatefulWidget {
  @override
  _ManagerDiscountState createState() => _ManagerDiscountState();
}

class _ManagerDiscountState extends State<ManagerDiscount> {
  // Stream<List<dynamic>> listItem;
  final discountController = Get.put(DiscountController());
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    discountController.initialController();
    discountController.getAllDiscount();
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
            child: DrawerLayoutAdmin(status: 4),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            icon: SvgPicture.asset("assets/icons/menu.svg"),
          ),
          title: Text(
            'Quản lý giảm giá',
            style: TextStyle(
              color: Colors.white,
              fontSize: _size.width / 20.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.CREATE_DISCOUNT);
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
              Container(
                height: 160.w,
                child: GetBuilder<DiscountController>(
                  init: discountController,
                  builder: (_) => ListView.builder(
                    controller: scrollController,
                    itemCount: discountController.listDiscount.length,
                    itemBuilder: (context, index) {
                      return DiscountItem(
                        discount: DiscountModel.fromMap(_.listDiscount[index]),
                      );
                    },
                  ),
                ),
              ),

              // Container(
              //   decoration:
              //       BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              // ),
            ],
          ),
          // bottomNavigationBar: CartTotal(),
        ));
  }
}
