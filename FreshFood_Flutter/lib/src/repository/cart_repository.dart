import 'dart:convert';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';

class CartRepository {
  Future<List<dynamic>> getProductCart() async {
    var response = await HandleApis().get(ApiGateway.GETCART);

    if (response.statusCode == 200) {
      print("hello");
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<dynamic> addToCart(String productId, int quantity) async {
    var body = {
      "productId": productId,
      "quantity": quantity,
    };
    var response = await HandleApis().post(ApiGateway.ADD_TO_CART, body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<dynamic> updateCart(List<Map<String, dynamic>> cart) async {
    var body = cart;
    var response = await HandleApis().putArray(ApiGateway.UPDATE_CART, body);
    print(jsonEncode(body));

    print("chonayne");

    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }
}
