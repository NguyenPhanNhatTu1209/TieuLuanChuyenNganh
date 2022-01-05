import 'dart:async';
import 'dart:convert';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';

class GroupProductRepository {
  Future<List<dynamic>> getGroupProduct() async {
    var response = await HandleApis().get(
      ApiGateway.GETGROUPPRODUCT,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<Map<String, dynamic>> createBook(String id) async {
    var body = {
      'id': id,
    };
    var response = await HandleApis().post(
      ApiGateway.GET_RECOMMEND,
      body,
    );

    print(body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }
}
