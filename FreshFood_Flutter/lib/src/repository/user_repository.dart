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

  Future<dynamic> updateImage({File avatar}) async {
    var request = http.MultipartRequest(
        'POST', Uri.https(root_url, ApiGateway.UPDATE_IMAGE));
    request.headers["Content-Type"] = 'multipart/form-data';
    request.headers["Authorization"] =
        'Bearer ' + (userProvider.user == null ? '' : userProvider.user.token);
    request.files.add(http.MultipartFile.fromBytes(
      "image",
      avatar.readAsBytesSync(),
      filename: avatar.path,
    ));
    var response = await http.Response.fromStream(await request.send());
    print("phongtu");

    print(response.statusCode);
    if ([200, 201].contains(response.statusCode)) {
      var jsonResult = jsonDecode(response.body)['data'];
      return jsonResult;
    }

    return null;
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
    print(body);
    var response = await HandleApis().put(ApiGateway.UPDATE_ADDRESS, body);
    print("response ne");
    print(response.statusCode);

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
    print(response.body.toString());
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
