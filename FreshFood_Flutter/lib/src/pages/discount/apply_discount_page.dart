import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/models/discount.dart';
import 'package:freshfood/src/pages/Admin/widget/drawer_layout_admin.dart';
import 'package:freshfood/src/pages/discount/controllers/discount_controlller.dart';
import 'package:freshfood/src/pages/discount/widget/discount_item_user.dart';
import 'package:freshfood/src/pages/payment/widget/default_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ApplyDiscountPage extends StatefulWidget {
  @override
  _ApplyDiscountPageState createState() => _ApplyDiscountPageState();
}

class _ApplyDiscountPageState extends State<ApplyDiscountPage> {
  // Stream<List<dynamic>> listItem;
  final discountController = Get.put(DiscountController());
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    discountController.initialController();
    discountController.getDiscountActive();
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
            onPressed: () => Get.back(),
            icon: Icon(
              PhosphorIcons.arrow_left,
              color: Colors.white,
              size: 8.w,
            ),
          ),
          title: Text(
            'Chọn voucher giảm giá',
            style: TextStyle(
              color: Colors.white,
              fontSize: _size.width / 20.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
            height: 100.h,
            width: 100.w,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 76.h,
                    child: GetBuilder<DiscountController>(
                      init: discountController,
                      builder: (_) => ListView.builder(
                        controller: scrollController,
                        itemCount: discountController.listDiscount.length,
                        itemBuilder: (context, index) {
                          return DiscountItemUser(
                            discount:
                                DiscountModel.fromMap(_.listDiscount[index]),
                            index: index,
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: DefaultButton(
                      btnText: 'Áp dụng',
                      onPressed: () {
                        discountController.applyDiscount();
                        Get.back();
                      },
                    ),
                  )

                  // Container(
                  //   decoration:
                  //       BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                  // ),
                ],
              ),
            )));
  }
}
