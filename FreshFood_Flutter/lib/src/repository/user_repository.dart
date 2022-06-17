import 'dart:convert';
import 'dart:io';
import 'package:freshfood/src/models/user.dart';
import 'package:freshfood/src/providers/user_provider.dart';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<dynamic> getProfile() async {
    var response = await HandleApis().get(ApiGateway.GET_PROFILE);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<bool> updateImage({String avatar}) async {
    var body = {"avatar": avatar};
    var response = await HandleApis().post(ApiGateway.UPDATE_IMAGE, body);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<dynamic>> getAllAddress() async {
    var response = await HandleApis().get(ApiGateway.GET_ADDRESS);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<bool> addAddress(String name, String phone, String province,
      String district, String address, bool isMain) async {
    var body = {
      "name": name,
      "phone": phone,
      "province": province,
      "district": district,
      "address": address,
      "isMain": isMain,
    };
    var response = await HandleApis().post(ApiGateway.ADD_ADDRESS, body);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> updateAddress(String id, String name, String phone,
      String province, String district, String address, bool isMain) async {
    var body = {
      "name": name,
      "phone": phone,
      "province": province,
      "district": district,
      "address": address,
      "isMain": isMain,
      "id": id,
    };
    var response = await HandleApis().put(ApiGateway.UPDATE_ADDRESS, body);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> deleteAddress(String id) async {
    var response = await HandleApis().delete(
      ApiGateway.DELETE_ADDRESS,
      'id=$id',
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<dynamic>> getMessage({int skip, String idRoom}) async {
    var response = await HandleApis().get(
      ApiGateway.GET_MESSAGE,
      'skip=$skip&idRoom=$idRoom',
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<List<dynamic>> getRoom(int skip) async {
    var response = await HandleApis().get(ApiGateway.GET_LiST_ROOM);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return [];
  }

  Future<bool> updateUser({String phone, String name}) async {
    var body = {
      "phone": phone,
      "name": name,
    };
    var response = await HandleApis().put(ApiGateway.UPDATE_PROFILE, body);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
