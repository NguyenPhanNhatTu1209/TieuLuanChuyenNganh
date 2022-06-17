import 'dart:async';
import 'dart:convert';

import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';

class AnswerRepository {
  Future<dynamic> createAnswer({String questionId, String result}) async {
    var body = {'questionId': questionId, 'result': result};
    var response = await HandleApis().post(ApiGateway.CREATE_ANSWER, body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return null;
  }

  // Future<Map<String, dynamic>> createBook(String id) async {
  //   var body = {
  //     'id': id,
  //   };
  //   var response = await HandleApis().post(
  //     ApiGateway.CREATE,
  //     body,
  //   );

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body)['data'];
  //   }
  //   return null;
  // }
}
