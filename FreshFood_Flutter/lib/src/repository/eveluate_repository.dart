import 'dart:convert';
import 'dart:io';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';
import 'package:http/http.dart' as http;

class EveluateRepository {
  Future<List<dynamic>> getEveluateByProduct(
      {String productId, int skip, int limit}) async {
    var response = await HandleApis().get(
      ApiGateway.GET_EVELUATE,
      'productId=$productId&skip=$skip&limit=$limit',
    );
    print(jsonDecode(response.body)['data']);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<dynamic> createEveluate({List<Map<String, dynamic>> product}) async {
    print(jsonEncode(product));
    var response =
        await HandleApis().postArray(ApiGateway.CREATE_EVELUATE, product);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }
}
