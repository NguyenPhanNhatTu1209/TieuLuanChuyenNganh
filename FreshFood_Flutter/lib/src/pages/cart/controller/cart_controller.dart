import 'dart:async';
import 'dart:math';
import 'package:freshfood/src/models/cart_model.dart';
import 'package:freshfood/src/models/cart_update_model.dart';
import 'package:freshfood/src/repository/cart_repository.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  List<dynamic> listProductCart = [];
  int pageNum = 1;

  String totalQuantity = "0";
  // String total = '0';
  StreamController<String> _total = StreamController<String>.broadcast();

  StreamController<List<dynamic>> listProductCartController =
      StreamController<List<dynamic>>.broadcast();
  initialController() {
    listProductCart = [];
    print("testne");
  }

  getTotalMoney() {
    double temp = 0;
    listProductCart.forEach((element) {
      if (element['selected'] == 1 && element['status'] != 0) {
        temp += element['cost'] * element['quantity'];
      }
    });
    _total.add(temp.toString());
    update();
  }

  getTotalQuantity() {
    int temp = 0;
    listProductCart.forEach((element) {
      if (element['status'] == 1) temp += element['quantity'];
    });
    print("halo");
    print(temp);
    totalQuantity = temp.toString();
    update();
  }

  changeStatusItem(index) {
    if (listProductCart[index]['selected'] == 1)
      listProductCart[index]['selected'] = 0;
    else
      listProductCart[index]['selected'] = 1;
    getTotalMoney();
  }

  deleteItem() {
    listProductCart.forEach((element) {
      if (element['selected'] == 1) {
        element['status'] = 0;
        // temp.add(element);
      }
    });

    // listProductCart.removeWhere((element) => temp.contains(element));
    listProductCartController.add(listProductCart);
    update();
    getTotalMoney();
    getTotalQuantity();
  }

  increaseQuantity(index) {
    // if(listProductCart[index]['quantity'] )
    // {
    listProductCart[index]['quantity']++;
    getTotalMoney();
    getTotalQuantity();
    // }
  }

  decreaseQuantity(index) {
    if (listProductCart[index]['quantity'] > 1) {
      listProductCart[index]['quantity']--;
      getTotalMoney();
      getTotalQuantity();
    }
  }

  selectAllCart() {
    listProductCart.forEach((element) {
      element['selected'] = 1;
    });
    getTotalMoney();
  }

  deleteAllCart() {
    listProductCart.forEach((element) {
      element['selected'] = 0;
    });
    getTotalMoney();
  }

  getListProduct() {
    CartRepository().getProductCart().then((value) {
      print(value);
      if (value.isNotEmpty) {
        listProductCart = value;
        getTotalQuantity();
        listProductCartController.add(listProductCart);
        update();
      }
    });
  }

  updateCart() {
    CartRepository()
        .updateCart(listProductCart
            .map((data) => CartUpdateModel.fromMap(data).toMap())
            .toList())
        .then((value) {
      getTotalQuantity();
      print(value);
      if (value.isNotEmpty) {
        print("updatecartthanhcong1");
      }
    });
  }

  Stream<List<dynamic>> get listProduct => listProductCartController.stream;
  Stream<String> get total => _total.stream;
}
