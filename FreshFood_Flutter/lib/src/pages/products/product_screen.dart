import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/pages/products/controllers/group_product_controller.dart';
import 'package:freshfood/src/pages/products/widget/product_card.dart';
import 'package:freshfood/src/pages/home/controllers/product_controller.dart';
import 'package:freshfood/src/pages/products/widget/drawer_layout.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProductPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final productController = Get.put(ProductController());
  ScrollController scrollController = ScrollController();
  String _search = '';
  final _groupProduct = Get.put(GroupProductController());

  @override
  void initState() {
    super.initState();
    productController.initialController();
    _groupProduct.initialController();
    _groupProduct.getGroupProduct();
    productController.getAllProduct(search: _search, groupProduct: '');
    print(_groupProduct.selected);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          if (_groupProduct.selected.toString() == '{}') {
            productController.getAllProduct(search: _search, groupProduct: '');
          } else {
            print(_groupProduct.selected);
            productController.getAllProduct(
                search: _search, groupProduct: _groupProduct.selected['key']);
          }
        }
      }
    });
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
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
              icon: SvgPicture.asset("assets/icons/menu.svg"),
            ),
            title: Center(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 54,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: kPrimaryColor.withOpacity(0.23))
                    ]),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            hintText: "Tìm kiếm",
                            hintStyle: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) {
                            print(value);
                            _search = value;
                            productController.initialController();
                            if (_groupProduct.selected.toString() == '{}') {
                              productController.getAllProduct(
                                  search: _search, groupProduct: '');
                            } else {
                              productController.getAllProduct(
                                  search: _search,
                                  groupProduct: _groupProduct.selected['key']);
                            }
                          }),
                    ),
                    SvgPicture.asset("assets/icons/search.svg"),
                  ],
                ),
              ),
            )),
        body: Container(
            child: Column(children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: 24,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: kDefaultPadding / 4),
                        child: GetBuilder<ProductController>(
                          init: productController,
                          builder: (_) => Text(
                            productController.getNameOfWidget(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: EdgeInsets.only(right: kDefaultPadding / 4),
                            height: 7,
                            color: kPrimaryColor.withOpacity(0.2),
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 10.sp),
                Expanded(
                  child: StreamBuilder(
                    stream: productController.listProduct,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (snapshot.data.length == 0)
                        return Container(
                          child: Center(
                            child: Text(
                              'Không có sản phẩm',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );

                      return Container(
                        margin: EdgeInsets.only(left: 5.sp, right: 10.sp),
                        width: 100.w,
                        child: GridView.builder(
                          controller: scrollController,
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 1.55),
                            // crossAxisSpacing: 1.0,
                            // mainAxisExtent: 1.0,
                          ),
                          // scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              product:
                                  ProductModel.fromMap(snapshot.data[index]),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ])));
  }
}
