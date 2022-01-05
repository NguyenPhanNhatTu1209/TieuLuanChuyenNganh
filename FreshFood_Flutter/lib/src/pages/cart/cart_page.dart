import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:freshfood/src/helpers/money_formatter.dart';
import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/pages/cart/controller/cart_controller.dart';
import 'package:freshfood/src/pages/cart/widgets/cart_item.dart';
import 'package:freshfood/src/pages/cart/widgets/cart_item_button.dart';
import 'package:freshfood/src/public/styles.dart';
import 'package:freshfood/src/routes/app_pages.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Stream<List<dynamic>> listItem;
  final cartController = Get.put(CartController());
  bool selectAll;
  double total = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.initialController();
    cartController.getListProduct();
    // cartController.getTotalMoney(listCart)();

    selectAll = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    cartController.updateCart();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
        // backgroundColor: AppColors.LIGHT,
        appBar: AppBar(
          centerTitle: true,
          elevation: .0,
          backgroundColor: kPrimaryColor,
          brightness: Brightness.light,
          leading: Get.currentRoute == Routes.CART
              ? IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    PhosphorIcons.arrow_left,
                    color: Colors.white,
                    size: 7.w,
                  ),
                )
              : null,
          title: Text(
            'Giỏ hàng',
            style: TextStyle(
              color: Colors.white,
              fontSize: _size.width / 20.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => cartController.deleteItem(),
              icon: Icon(
                PhosphorIcons.trash,
                size: 7.w,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300)),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: selectAll == false
                        ? Icon(
                            Icons.check_box_outline_blank_outlined,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.check_box_rounded,
                            color: Colors.green,
                          ),
                    onPressed: () {
                      setState(() {
                        if (selectAll == false) {
                          selectAll = true;
                          cartController.selectAllCart();
                        } else {
                          selectAll = false;
                          cartController.deleteAllCart();
                        }
                      });
                    },
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    "Tất cả",
                    style: TextStyle(
                      fontSize: 4.w,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Tổng tiền:",
                          style: TextStyle(
                            fontSize: 4.w,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Container(
                          width: 32.w,
                          child: Center(
                              child: StreamBuilder(
                                  stream: cartController.total,
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (!snapshot.hasData) {
                                      return Text(
                                        formatMoney(0),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 5.w,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    }
                                    return Text(
                                      formatMoney(
                                          double.tryParse(snapshot.data)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 5.w,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    );
                                    // child: Text(
                                    //   cartController.total,
                                    //   maxLines: 1,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: TextStyle(
                                    //     fontSize: 5.w,
                                    //     color: Colors.green,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // ),
                                  })),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5.w),
                  FlatButton(
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        List<CartModel> temp = cartController.listProductCart
                            .map((data) => CartModel.fromMap(data))
                            .where((element) =>
                                element.selected == 1 && element.status == 1)
                            .toList();

                        print(temp);
                        if (temp.length <= 0) {
                          GetSnackBar getSnackBar = GetSnackBar(
                            title: 'Bạn chưa chọn sản phẩm nào',
                            subTitle:
                                'Vui lòng chọn ít nhất 1 sản phẩm để thanh toán',
                          );
                          getSnackBar.show();
                        } else {
                          Get.toNamed(Routes.DETAIL_PAYMENT,
                              arguments: {"list": temp, "isBuyNow": false});
                        }
                      },
                      child: Text(
                        'Thanh toán',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                height: 145.w,
                child: StreamBuilder(
                    stream: cartController.listProduct,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.data
                                  .where((x) => x['status'] == 1)
                                  .toList()
                                  .length ==
                              0) {
                        return Container(
                          child: Center(
                            child: Text(
                              'Chưa có sản phẩm nào trong giỏ hàng!',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }

                      // listCart = (snapshot.data as List<dynamic>)
                      //     .map((data) => CartModel.fromMap(data))
                      //     .toList();
                      return Container(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return snapshot.data[index]['status'] == 1
                                ? CartItem(
                                    cart:
                                        CartModel.fromMap(snapshot.data[index]),
                                    cartController: cartController,
                                    listCart: (snapshot.data as List<dynamic>)
                                        .map((data) => CartModel.fromMap(data))
                                        .toList(),
                                    index: index,
                                  )
                                : Container();
                          },
                        ),
                      );
                    }),
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
