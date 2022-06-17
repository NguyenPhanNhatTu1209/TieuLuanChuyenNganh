import 'dart:async';
import 'package:flutter/material.dart';
import 'package:freshfood/src/models/history.dart';
import 'package:freshfood/src/models/inventory_model.dart';
import 'package:freshfood/src/repository/inventory_history_repository.dart';
import 'package:freshfood/src/repository/product_repository.dart';
import 'package:freshfood/src/utils/snackbar.dart';
import 'package:get/get.dart';

class InventoryHistoryController extends GetxController {
  List<dynamic> listImportInventory = [];
  List<dynamic> listProduct = [];
  int skip = 1;
  List<dynamic> listCreateInventory = [];

  initialController() {
    listImportInventory = [];
  }

  initCreateInventory() {
    skip = 1;
    listProduct.clear();
    listCreateInventory.clear();
  }

  initFindInventory() {
    skip = 1;
    listProduct.clear();
  }

  getInventoryHistory() {
    InventoryHistoryRepository().getAllIventoryHistory().then((value) {
      if (value.isNotEmpty) {
        listImportInventory.addAll(value);
        update();
      }
    });
  }

  getProduct({String search}) {
    if (skip == -1) {
      return;
    }

    ProductRepository().getAllProduct(search, skip, 10, '').then((value) {
      if (value != null && value.length > 0) {
        for (var i = 0; i < value.length; i++) {
          var index = listCreateInventory.length == 0
              ? -1
              : listCreateInventory
                  ?.indexWhere((x) => x['_id'] == value[i]['_id']);
          if (index != -1) {
            value[i] = listCreateInventory[index];
          } else {
            if (value[i]['priceDiscount'] == 0) {
              value[i]['priceDiscount'] = value[i]['price'];
            }
          }
        }
        listProduct.addAll(value);
        skip++;
        update();
      } else {
        skip = -1;
      }
    });
  }

  updateQuantity(String id, bool isIncrease) {
    var index = listProduct.indexWhere((element) => element['_id'] == id);

    if (isIncrease) {
      listProduct[index]['quantityChange']++;
    } else {
      if (-listProduct[index]['quantityChange'] <
          listProduct[index]['quantity']) {
        listProduct[index]['quantityChange']--;
      }
    }
    var indexListCreate = listCreateInventory.length == 0
        ? -1
        : listCreateInventory.indexWhere((x) => x['_id'] == id);
    if (indexListCreate == -1) {
      listCreateInventory.add(listProduct[index]);
    } else {
      listCreateInventory[indexListCreate] = listProduct[index];
    }

    update();
  }

  changePrice(String id, String value, bool isDiscount) {
    var index = listProduct.indexWhere((element) => element['_id'] == id);
    isDiscount
        ? listProduct[index]['priceDiscount'] = int.tryParse(value)
        : listProduct[index]['price'] = int.tryParse(value);

    var indexListCreate = listCreateInventory.length == 0
        ? -1
        : listCreateInventory.indexWhere((x) => x['_id'] == id);
    if (indexListCreate == -1) {
      listCreateInventory.add(listProduct[index]);
    } else {
      listCreateInventory[indexListCreate] = listProduct[index];
    }

    update();
  }

  createInventoryHistory(BuildContext context) {
    var listHistory = listCreateInventory
        .map((e) => InventoryModel.fromMap(e).toMap())
        .toList();
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      },
      barrierColor: Color(0x80000000),
      barrierDismissible: false,
    );
    InventoryHistoryRepository()
        .createIventoryHistory(listHistory)
        .then((value) {
      Get.back();

      if (value != null) {
        initialController();
        getInventoryHistory();
        Get.back();
      } else {
        GetSnackBar getSnackBar = GetSnackBar(
          title: 'Tạo phiếu nhập kho thất bại',
          subTitle: '',
        );
        getSnackBar.show();
      }
    });
  }
}
