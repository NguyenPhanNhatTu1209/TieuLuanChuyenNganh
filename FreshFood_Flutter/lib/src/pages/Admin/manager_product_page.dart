import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/Admin/widget/drawer_layout_admin.dart';
import 'package:freshfood/src/pages/Admin/widget/product_item.dart';
import 'package:freshfood/src/pages/cart/controller/cart_controller.dart';
import 'package:freshfood/src/pages/cart/widgets/cart_item.dart';
import 'package:freshfood/src/pages/cart/widgets/cart_item_button.dart';
import 'package:freshfood/src/pages/home/controllers/product_controller.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/services/fcm.dart';
import 'package:freshfood/src/services/socket.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ManagerProductPage extends StatefulWidget {
  @override
  _ManagerProductPageState createState() => _ManagerProductPageState();
}

class _ManagerProductPageState extends State<ManagerProductPage> {
  // Stream<List<dynamic>> listItem;
  final productController = Get.put(ProductController());
  ScrollController scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _search = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.initialController();
    productController.getAllProduct(search: '', groupProduct: '');
    handleReceiveNotification(context);
    connectAndListen();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          productController.getAllProduct(search: _search, groupProduct: '');
        }
      }
    });
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
            child: DrawerLayoutAdmin(status: 0),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
            icon: SvgPicture.asset("assets/icons/menu.svg"),
          ),
          title: Text(
            'Tất cả sản phẩm',
            style: TextStyle(
              color: Colors.white,
              fontSize: _size.width / 20.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.CREATE_PRODUCT);
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
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      _search = value;
                      productController.initialController();
                      productController.getAllProduct(
                          search: _search, groupProduct: '');
                    }),
              ),
              Container(
                height: 160.w,
                child: GetBuilder<ProductController>(
                  init: productController,
                  builder: (_) => ListView.builder(
                    controller: scrollController,
                    itemCount: productController.listAllProduct.length,
                    itemBuilder: (context, index) {
                      return ProductItem(
                        product: ProductModel.fromMap(_.listAllProduct[index]),
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
