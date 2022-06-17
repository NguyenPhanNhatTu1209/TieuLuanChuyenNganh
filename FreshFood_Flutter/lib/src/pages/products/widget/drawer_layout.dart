import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/pages/home/controllers/product_controller.dart';
import 'package:freshfood/src/pages/products/controllers/group_product_controller.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DrawerLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  final _groupProduct = Get.put(GroupProductController());
  final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 90.h,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'http://freshfoods.vn/images/freshfoods.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      _groupProduct.selected = {};
                      productController.initialController();
                      productController.getAllProduct(
                          search: '', groupProduct: '');
                      Get.back();
                    },
                    child: _buildLineDrawer(
                      context,
                      'Tất cả',
                      null,
                    ),
                  ),
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        itemCount: _groupProduct.groupProduct.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _groupProduct.selected =
                                  _groupProduct.groupProduct[index];
                              productController.initialController();
                              productController.getAllProduct(
                                  search: '',
                                  groupProduct: _groupProduct.selected['key']);
                              Get.back();
                            },
                            child: _buildLineDrawer(
                              context,
                              _groupProduct.groupProduct[index]['name'],
                              null,
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 18.sp, right: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Loại hàng',
                  style: TextStyle(
                    color: colorDarkGrey,
                    fontSize: 8.5.sp,
                    // fontFamily: FontFamily.lato,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLineDrawer(context, String title, icon) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.25.sp, horizontal: 10.sp),
      color: Colors.transparent,
      child: Row(
        children: [
          Icon(
            icon,
            size: 17.25.sp,
          ),
          SizedBox(width: 10.sp),
          Text(
            title,
            style: TextStyle(
              color: _groupProduct.selected.toString() != '{}'
                  ? title == _groupProduct.selected['name']
                      ? kPrimaryColor
                      : colorTitle
                  : title == "Tất cả"
                      ? kPrimaryColor
                      : colorTitle,
              fontSize: 11.25.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
