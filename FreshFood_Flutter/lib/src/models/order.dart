import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:freshfood/src/models/address.dart';
import 'package:freshfood/src/models/history.dart';
import 'package:freshfood/src/models/product.dart';
import 'package:freshfood/src/models/product_order_model.dart';

class OrderModel {
  final String id;
  List<ProductOrderModel> product;
  List<HistoryModel> history;
  int status;
  String orderCode;
  double totalMoney;
  double shipFee;
  String typePayment;
  String address;
  String customerId;
  DateTime createdAt;
  DateTime updatedAt;
  AddressModel area;
  bool checkEveluate;
  OrderModel({
    this.id,
    this.product,
    this.history,
    this.status,
    this.orderCode,
    this.totalMoney,
    this.shipFee,
    this.typePayment,
    this.address,
    this.customerId,
    this.createdAt,
    this.updatedAt,
    this.area,
    this.checkEveluate,
  });

  OrderModel copyWith({
    String id,
    List<ProductModel> product,
    List<HistoryModel> history,
    int status,
    String orderCode,
    double totalMoney,
    double shipFee,
    String typePayment,
    String address,
    String customerId,
    DateTime createdAt,
    DateTime updatedAt,
    AddressModel area,
  }) {
    return OrderModel(
      id: id ?? this.id,
      product: product ?? this.product,
      history: history ?? this.history,
      status: status ?? this.status,
      orderCode: orderCode ?? this.orderCode,
      totalMoney: totalMoney ?? this.totalMoney,
      shipFee: shipFee ?? this.shipFee,
      typePayment: typePayment ?? this.typePayment,
      address: address ?? this.address,
      customerId: customerId ?? this.customerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      area: area ?? this.area,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product': product?.map((x) => x.toMap())?.toList(),
      'history': history?.map((x) => x.toMap())?.toList(),
      'status': status,
      'orderCode': orderCode,
      'totalMoney': totalMoney,
      'shipFee': shipFee,
      'typePayment': typePayment,
      'address': address,
      'customerId': customerId,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'area': area.toMap(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['_id'],
      product: List<ProductOrderModel>.from(
          map['product']?.map((x) => ProductOrderModel.fromMap(x))),
      history: List<HistoryModel>.from(
          map['history']?.map((x) => HistoryModel.fromMap(x))),
      status: map['status'],
      orderCode: map['orderCode'],
      totalMoney: double.tryParse((map['totalMoney'] ?? 0).toString()),
      shipFee: double.tryParse((map['shipFee'] ?? 0).toString()),
      typePayment: map['typePayment'],
      address: map['address'],
      customerId: map['customerId'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      area: AddressModel.fromMap(map['area']),
      checkEveluate: map['checkEveluate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, product: $product, history: $history, status: $status, orderCode: $orderCode, totalMoney: $totalMoney, shipFee: $shipFee, typePayment: $typePayment, address: $address, customerId: $customerId, createdAt: $createdAt, updatedAt: $updatedAt, area: $area)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        listEquals(other.product, product) &&
        listEquals(other.history, history) &&
        other.status == status &&
        other.orderCode == orderCode &&
        other.totalMoney == totalMoney &&
        other.shipFee == shipFee &&
        other.typePayment == typePayment &&
        other.address == address &&
        other.customerId == customerId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.area == area;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        product.hashCode ^
        history.hashCode ^
        status.hashCode ^
        orderCode.hashCode ^
        totalMoney.hashCode ^
        shipFee.hashCode ^
        typePayment.hashCode ^
        address.hashCode ^
        customerId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        area.hashCode;
  }
}
