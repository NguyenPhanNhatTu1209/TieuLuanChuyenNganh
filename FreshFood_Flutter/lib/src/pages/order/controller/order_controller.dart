import 'package:freshfood/src/models/order.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/repository/order_repository.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  List<OrderModel> list0 = [];
  List<OrderModel> list1 = [];
  List<OrderModel> list2 = [];
  List<OrderModel> list3 = [];
  List<OrderModel> list4 = [];
  initController() {
    list0 = [];
    list1 = [];
    list2 = [];
    list3 = [];
    list4 = [];
  }

  //Chờ xác nhận
  getOrder({
    String search,
    int skip,
    int limit,
  }) {
    OrderRepository()
        .getOrders(search: search, skip: skip, limit: limit, status: 0)
        .then((value) {
      if (value != null)
        list0 = value.map((e) => OrderModel.fromMap(e)).toList();
      update();
    });
    OrderRepository()
        .getOrders(search: search, skip: skip, limit: limit, status: 1)
        .then((value) {
      if (value != null)
        list1 = value.map((e) => OrderModel.fromMap(e)).toList();
      update();
    });
    OrderRepository()
        .getOrders(search: search, skip: skip, limit: limit, status: 2)
        .then((value) {
      if (value != null)
        list2 = value.map((e) => OrderModel.fromMap(e)).toList();
      update();
    });
    OrderRepository()
        .getOrders(search: search, skip: skip, limit: limit, status: 3)
        .then((value) {
      if (value != null)
        list3 = value.map((e) => OrderModel.fromMap(e)).toList();
      update();
    });
    OrderRepository()
        .getOrders(search: search, skip: skip, limit: limit, status: 4)
        .then((value) {
      if (value != null)
        list4 = value.map((e) => OrderModel.fromMap(e)).toList();
      update();
    });
  }

  getOrderByAdmin({
    String search,
    int skip,
    int limit,
  }) {
    OrderRepository()
        .getOrdersByAdmin(search: search, skip: skip, limit: limit, status: 0)
        .then((value) {
      if (value != null)
        list0 = value.map((e) => OrderModel.fromMap(e)).toList();
      Future.delayed(Duration(milliseconds: 20), () {
        update();
      });
    });
    OrderRepository()
        .getOrdersByAdmin(search: search, skip: skip, limit: limit, status: 1)
        .then((value) {
      if (value != null)
        list1 = value.map((e) => OrderModel.fromMap(e)).toList();
      Future.delayed(Duration(milliseconds: 20), () {
        update();
      });
    });
    OrderRepository()
        .getOrdersByAdmin(search: search, skip: skip, limit: limit, status: 2)
        .then((value) {
      if (value != null)
        list2 = value.map((e) => OrderModel.fromMap(e)).toList();
      Future.delayed(Duration(milliseconds: 20), () {
        update();
      });
    });
    OrderRepository()
        .getOrdersByAdmin(search: search, skip: skip, limit: limit, status: 3)
        .then((value) {
      if (value != null)
        list3 = value.map((e) => OrderModel.fromMap(e)).toList();
      Future.delayed(Duration(milliseconds: 20), () {
        update();
      });
    });
    OrderRepository()
        .getOrdersByAdmin(search: search, skip: skip, limit: limit, status: 4)
        .then((value) {
      if (value != null)
        list4 = value.map((e) => OrderModel.fromMap(e)).toList();
      Future.delayed(Duration(milliseconds: 20), () {
        update();
      });
    });
  }

  String getStatus(status, checkEveluate) {
    if (userProvider.user.role == 0) {
      return status == 2
          ? 'Đã nhận'
          : checkEveluate == false && status == 3
              ? 'Đánh giá'
              : '';
    }
    switch (status) {
      case 0:
        return 'Xác nhận';
      case 1:
        return 'Giao hàng';
      case 2:
        {
          return 'Đã giao';
        }
    }
    return '';
  }
}
