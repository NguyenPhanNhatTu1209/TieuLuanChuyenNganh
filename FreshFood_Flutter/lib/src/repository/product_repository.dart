import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<dynamic>> getRecommendProduct(skip, limit) async {
    var response = await HandleApis().get(ApiGateway.GET_RECOMMEND);

    if (response.statusCode == 200) {
      print("huhu");
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
    List<File> images,
    double weight,
    double price,
    int quantity,
    String name,
    String detail,
    String groupProduct,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.https(root_url, 'product/createProduct'));
    request.headers["Content-Type"] = 'multipart/form-data';
    request.headers["Authorization"] =
        'Bearer ' + (userProvider.user == null ? '' : userProvider.user.token);

    request.fields.addAll({
      'name': name,
      'detail': detail,
      'price': price.toString(),
      'groupProduct': groupProduct,
      'weight': weight.toString(),
      'quantity': quantity.toString(),
    });

    if (images != null) {
      images.forEach((image) {
        print("aaaaaa");

        request.files.add(
          http.MultipartFile.fromBytes(
            "image",
            image.readAsBytesSync(),
            filename: image.path,
          ),
        );
      });
    }
    if (request.files.length == 0) return null;

    var response = await http.Response.fromStream(await request.send());
    print(response.statusCode);
    print(jsonDecode(response.body));
    if ([200, 201].contains(response.statusCode)) {
      var jsonResult = jsonDecode(response.body)['data'];
      return ProductModel.fromMap(jsonResult);
    }

    return null;
  }

  Future<ProductModel> updateProduct({
    List<File> images,
    double weight,
    double price,
    int quantity,
    String name,
    String detail,
    String groupProduct,
    String id,
  }) async {
    var request = http.MultipartRequest(
        'PUT', Uri.https(root_url, 'product/updateProduct'));
    request.headers["Content-Type"] = 'multipart/form-data';
    request.headers["Authorization"] =
        'Bearer ' + (userProvider.user == null ? '' : userProvider.user.token);

    request.fields.addAll({
      'name': name,
      'detail': detail,
      'price': price.toString(),
      'groupProduct': groupProduct,
      'weight': weight.toString(),
      'quantity': quantity.toString(),
      "id": id,
    });

    if (images != null) {
      images.forEach((image) {
        print("aaaaaa");

        request.files.add(
          http.MultipartFile.fromBytes(
            "image",
            image.readAsBytesSync(),
            filename: image.path,
          ),
        );
      });
    }
    // if (request.files.length == 0) return null;
    print(request.fields);
    var response = await http.Response.fromStream(await request.send());
    print(response.statusCode);
    print(jsonDecode(response.body));
    if ([200, 201].contains(response.statusCode)) {
      var jsonResult = jsonDecode(response.body)['data'];
      return ProductModel.fromMap(jsonResult);
    }

    return null;
  }

  Future<List<dynamic>> getProductUser() async {
    var response = await HandleApis().get(
      ApiGateway.PRODUCT_USER,
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print("huhu");
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<bool> createProductUser(String productId) async {
    var body = {"productId": productId};
    print(body);
    var response =
        await HandleApis().post(ApiGateway.CREATE_PRODUCT_USER, body);
    print(response.body);

    if (response.statusCode == 200) {
      print("add product user success");
      return true;
    }

    return false;
  }
}
