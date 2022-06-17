import 'dart:async';
import 'dart:convert';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';

class ProductRepository {
  Future<List<dynamic>> getRecommendProduct(skip, limit) async {
    var response = await HandleApis().get(ApiGateway.GET_RECOMMEND);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<List<dynamic>> getAllProduct(search, skip, limit, groupProduct) async {
    var response = await HandleApis().get(
      ApiGateway.GET_ALL_PRODUCT,
      'skip=$skip&limit=$limit&search=$search&groupProduct=$groupProduct',
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return null;
  }

  Future<dynamic> getDetail(id) async {
    var response = await HandleApis().get(
      ApiGateway.GET_DETAIL_PRODUCT,
      'id=$id',
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<ProductModel> createProduct({
    List<String> images,
    double weight,
    double price,
    int quantity,
    String name,
    String detail,
    String groupProduct,
  }) async {
    var body = {
      'name': name,
      'detail': detail,
      'price': price.toString(),
      'groupProduct': groupProduct,
      'weight': weight.toString(),
      'quantity': quantity.toString(),
      "image": images,
    };

    var response = await HandleApis().post(ApiGateway.CREATE_PRODUCt, body);
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['data'];
      return ProductModel.fromMap(jsonResult);
    }

    return null;
  }

  Future<ProductModel> updateProduct({
    List<String> images,
    double weight,
    double price,
    int quantity,
    String name,
    String detail,
    String groupProduct,
    String id,
  }) async {
    var body = {
      'name': name,
      'detail': detail,
      'price': price.toString(),
      'groupProduct': groupProduct,
      'weight': weight.toString(),
      'quantity': quantity.toString(),
      "id": id,
      "image": images,
    };

    var response = await HandleApis().put(ApiGateway.UPDATE_PRODUCT, body);
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['data'];
      return ProductModel.fromMap(jsonResult);
    }

    return null;
  }

  Future<List<dynamic>> getProductUser() async {
    var response = await HandleApis().get(
      ApiGateway.PRODUCT_USER,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<bool> createProductUser(String productId) async {
    var body = {"productId": productId};
    var response =
        await HandleApis().post(ApiGateway.CREATE_PRODUCT_USER, body);

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }
}
