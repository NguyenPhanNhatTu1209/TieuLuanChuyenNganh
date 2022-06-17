import 'dart:convert';

import 'package:freshfood/src/models/address.dart';
import 'package:http/http.dart' as http;

import 'api_gateway.dart';
import 'base_repository.dart';

class OrderRepository {
  Future<int> getShipFee({
    String address,
    String province,
    String district,
    double weight,
  }) async {
    Map<String, dynamic> paramsObject = {
      "address": address,
      "province": province,
      "district": district,
      "pick_province": 'Hồ Chí Minh',
      "pick_district": 'Thủ Đức',
      "weight": (weight * 1000).toString(),
    };

    http.Response response = await http.get(
      Uri.https("services.giaohangtietkiem.vn", "/services/shipment/fee",
          paramsObject),
      // Uri.http(root_url, '/' + name, paramsObject),
      headers: {'Token': '83b5796301Fc00A131eb690fA9d8B9B5cCf0497b'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['fee']['fee'];
    }
    return null;
  }

  Future<dynamic> createOrder(
      {List<String> cartId,
      AddressModel address,
      String note,
      int typePaymentOrder,
      String idDiscount,
      double bonusMoney}) async {
    var body = {
      "cartId": cartId,
      "area": {
        "name": address.name,
        "phone": address.phone,
        "province": address.province,
        "district": address.district,
        "address": address.address,
      },
      "note": note,
      "typePaymentOrder": typePaymentOrder,
      "idDiscount": idDiscount,
      "bonusMoney": bonusMoney,
    };
    var response = await HandleApis().post(ApiGateway.CREATE_ORDER, body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<dynamic> createOrderBuyNow({
    String productId,
    int quantity,
    AddressModel address,
    String note,
    int typePaymentOrder,
    String idDiscount,
    double bonusMoney,
  }) async {
    var body = {
      "productId": productId,
      "quantity": quantity,
      "area": {
        "name": address.name,
        "phone": address.phone,
        "province": address.province,
        "district": address.district,
        "address": address.address
      },
      "note": note,
      "typePaymentOrder": typePaymentOrder,
      "idDiscount": idDiscount,
      "bonusMoney": bonusMoney,
    };
    var response =
        await HandleApis().post(ApiGateway.CREATE_ORDER_BUY_NOW, body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }

  Future<List<dynamic>> getOrders({
    String search,
    int skip,
    int limit,
    int status,
  }) async {
    // Map<String, dynamic> paramsObject = {
    //   "search": search,
    //   "skip": skip,
    //   "limit": limit,
    //   "status": status,
    // };

    var response = await HandleApis().get(
      ApiGateway.GET_ORDER,
      'search=$search&status=$status&skip=$skip&limit=$limit',
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<List<dynamic>> getOrdersByAdmin({
    String search,
    int skip,
    int limit,
    int status,
  }) async {
    // Map<String, dynamic> paramsObject = {
    //   "search": search,
    //   "skip": skip,
    //   "limit": limit,
    //   "status": status,
    // };

    var response = await HandleApis().get(
      ApiGateway.GET_ORDER_ADMIN,
      'search=$search&status=$status&skip=$skip&limit=$limit',
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<bool> changeStatusOrderByAdminOrStaff({
    String id,
    int status,
  }) async {
    var body = {
      "id": id,
      "status": status,
    };

    var response = await HandleApis().put(
      ApiGateway.UPDATE_STATUS_ORDER,
      body,
    );

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
