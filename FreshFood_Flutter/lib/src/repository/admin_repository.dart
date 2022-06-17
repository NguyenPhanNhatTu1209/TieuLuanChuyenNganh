import 'dart:convert';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';

class AdminRepository {
  Future<List<dynamic>> getAllUser(search, skip, limit, role) async {
    var response = await HandleApis().get(ApiGateway.GET_ALL_USER,
        'skip=$skip&limit=$limit&search=$search&role=$role');
    print(jsonDecode(response.body)['data']);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<dynamic> getAvatar() async {
    var response = await HandleApis().get(
      ApiGateway.GET_AVATAR_ADMIN,
    );
    print(jsonDecode(response.body)['data']);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }

  Future<List<dynamic>> getstatisticOrder(
      String timeStart, String timeEnd) async {
    var response = await HandleApis().get(ApiGateway.GET_STATISTIC_ORDER,
        'timeStart=$timeStart&timeEnd=$timeEnd');
    print(jsonDecode(response.body)['data']);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<List<dynamic>> getstatisticProduct() async {
    var response = await HandleApis().get(ApiGateway.GET_STATISTIC_PRODUCT);
    print(jsonDecode(response.body)['data']);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<dynamic> getStatisticUser(String id) async {
    var response =
        await HandleApis().get(ApiGateway.GET_STATISTIC_USER, 'id=$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<dynamic> getUserById(String id) async {
    var response = await HandleApis().get(ApiGateway.GET_USER_BY_ID, 'id=$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }

  Future<Map<String, dynamic>> createStaff(
      String email, String phone, String password, String fullname) async {
    var body = {
      "email": email,
      "password": password,
      "phone": phone,
      "name": fullname,
    };
    var response = await HandleApis().post(
      ApiGateway.CREATE_STAFF,
      body,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }
}
