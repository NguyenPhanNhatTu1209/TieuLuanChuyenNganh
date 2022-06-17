import 'dart:async';
import 'dart:convert';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';

class GroupQuestionRepository {
  Future<List<dynamic>> getGroupQuestion() async {
    var response = await HandleApis().get(
      ApiGateway.GET_GROUP_QUESTION,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<Map<String, dynamic>> createGroupQuestion(String title) async {
    var body = {
      'title': title,
      'isActive': true,
    };
    var response = await HandleApis().post(
      ApiGateway.CREATE_GROUP_QUESTION,
      body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }

  Future<Map<String, dynamic>> updateGroupQuestion(
      String id, String title) async {
    var body = {
      'title': title,
      'id': id,
    };
    var response = await HandleApis().put(
      ApiGateway.UPDATE_GROUP_QUESTION,
      body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }

  Future<Map<String, dynamic>> updateStatusGroupQuestion(
      String id, bool isActive) async {
    var body = {
      'isActive': isActive,
      'id': id,
    };
    var response = await HandleApis().put(
      ApiGateway.UPDATE_GROUP_QUESTION,
      body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }

  Future<Map<String, dynamic>> createBook(String id) async {
    var body = {
      'id': id,
    };
    var response = await HandleApis().post(
      ApiGateway.GET_RECOMMEND,
      body,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }
}
