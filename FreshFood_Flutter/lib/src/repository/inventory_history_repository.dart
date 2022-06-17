import 'dart:async';
import 'dart:convert';
import 'package:freshfood/src/models/inventory_model.dart';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';

class InventoryHistoryRepository {
  Future<List<dynamic>> getAllIventoryHistory() async {
    var response = await HandleApis().get(
      ApiGateway.GET_HISTORY_INVENTORY,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<dynamic> createIventoryHistory(
      List<Map<String, dynamic>> listHistory) async {
    var response = await HandleApis().postArray(
      ApiGateway.CREATE_HISTORY_INVENTORY,
      listHistory,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }
    return null;
  }
}
