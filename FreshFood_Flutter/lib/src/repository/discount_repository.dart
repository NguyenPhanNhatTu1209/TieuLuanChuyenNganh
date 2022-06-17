import 'dart:async';
import 'dart:convert';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/repository/api_gateway.dart';
import 'package:freshfood/src/repository/base_repository.dart';

class DiscountRepository {
  Future<List<dynamic>> getAllDiscount(skip, limit) async {
    var response = await HandleApis().get(ApiGateway.GET_ALL_DISCOUNT);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<List<dynamic>> getDiscountActive() async {
    var response = await HandleApis().get(ApiGateway.GET_DISCOUNT_ACTIVE);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    }

    return [];
  }

  Future<dynamic> createDiscount({
    double percentDiscount,
    DateTime duration,
    DateTime startTime,
    int maxDiscount,
    int minimumDiscount,
    int quantity,
  }) async {
    var body = {
      'percentDiscount': percentDiscount,
      'duration': duration.toUtc().toString(),
      'startTime': startTime.toUtc().toString(),
      'maxDiscount': maxDiscount,
      'minimumDiscount': minimumDiscount,
      'quantity': quantity,
    };
    var response = await HandleApis().post(ApiGateway.CREATE_DISCOUNT, body);
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['data'];
      return jsonResult;
    }

    return null;
  }
}
