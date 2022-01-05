import 'dart:async';
import 'dart:convert';

import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';

class BookRepository {
  Future<List<dynamic>> getBooks(int page) async {
    var response = await HandleApis().get(
      ApiGateway.READ,
      'page=$page',
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  // Future<Map<String, dynamic>> createBook(String id) async {
  //   var body = {
  //     'id': id,
  //   };
  //   var response = await HandleApis().post(
  //     ApiGateway.CREATE,
  //     body,
  //   );

  //   print(body);
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body)['data'];
  //   }
  //   return null;
  // }
}
