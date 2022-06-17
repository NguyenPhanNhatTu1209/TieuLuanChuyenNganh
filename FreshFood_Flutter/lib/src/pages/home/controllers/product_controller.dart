import 'dart:async';

import 'package:freshfood/src/pages/products/controllers/group_product_controller.dart';
import 'package:freshfood/src/repository/product_repository.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  List<dynamic> _listRecomPro = [];
  List<dynamic> listAllProduct = [];
  List<dynamic> _listProductUser = [];

  int skip = 1;
  StreamController<List<dynamic>> _listRecommendController =
      StreamController<List<dynamic>>.broadcast();
  StreamController<List<dynamic>> _listProductController =
      StreamController<List<dynamic>>.broadcast();
  StreamController<List<dynamic>> _listProductUserController =
      StreamController<List<dynamic>>.broadcast();
  initialController() {
    _listRecomPro = [];
    _listProductUser = [];
    listAllProduct = [];
    skip = 1;
  }

  getRecommendProduct() {
    ProductRepository().getRecommendProduct(skip, 10).then((value) {
      if (value.isNotEmpty) {

        _listRecomPro.addAll(value);
        _listRecommendController.add(_listRecomPro);
        update();
      }
    });
    // if (pageNum != -1) {
    //   BookRepository().getBooks(pageNum).then((value) {
    //     if (value.length > 0) {
    //       listBook.addAll(value);
    //       pageNum++;
    //       update();
    //     } else {
    //       pageNum = -1;
    //       update();
    //     }
    //   });
    // }
  }

  getProduct() {
    ProductRepository().getRecommendProduct(1, 10).then((value) {
      if (value.isNotEmpty) {
        _listRecomPro.addAll(value);
        _listProductController.add(_listRecomPro);
        update();
      }
    });
  }

  getAllProduct({String search, String groupProduct}) {
    if (skip != -1) {
      ProductRepository()
          .getAllProduct(search, skip, 10, groupProduct)
          .then((value) {
        if (value != null) {
          listAllProduct.addAll(value);
          _listProductController.add(listAllProduct);
          skip++;
          update();
        } else {
          skip = -1;
          update();
        }
      });
    }
  }

  getProductUser() {
    ProductRepository().getProductUser().then((value) {
      if (value.isNotEmpty) {
        _listProductUser = value;
        _listProductUserController.add(_listProductUser);
        update();
      }
    });
  }

  String getNameOfWidget() {
    final _groupProduct = Get.put(GroupProductController());
    if (_groupProduct.selected.toString() == '{}') {
      return 'Tất cả';
    } else {
      return _groupProduct.selected['name'];
    }
  }

  Stream<List<dynamic>> get listProductRecommend =>
      _listRecommendController.stream;
  Stream<List<dynamic>> get listProduct => _listProductController.stream;
  Stream<List<dynamic>> get listProductUser =>
      _listProductUserController.stream;
}
