import 'dart:async';
import 'package:freshfood/src/repository/group_product_repository.dart';
import 'package:get/get.dart';

class GroupProductController extends GetxController {
  List<dynamic> groupProduct = [];
  dynamic selected = {};
  StreamController<List<dynamic>> _listGroupProductController =
      StreamController<List<dynamic>>.broadcast();

  initialController() {
    groupProduct = [];
    selected = {};
  }

  getGroupProduct() {
    GroupProductRepository().getGroupProduct().then((value) {
      if (value.isNotEmpty) {
        groupProduct.addAll(value);
        _listGroupProductController.add(groupProduct);
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

  Stream<List<dynamic>> get listGroupProduct =>
      _listGroupProductController.stream;
}
