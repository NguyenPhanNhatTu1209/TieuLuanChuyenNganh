import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:freshfood/src/models/group_product.dart';

class ProductModel {
  final String id;
  List<String> image;
  int status;
  double weight;
  double price;
  int quantity;
  String name;
  String detail;
  GroupProduct groupProduct;
  int number;
  double starAVG;
  int eveluateCount;
  int sold;

  ProductModel(
      {this.id,
      this.image,
      this.status,
      this.weight,
      this.price,
      this.quantity,
      this.name,
      this.detail,
      this.groupProduct,
      this.number = 1,
      this.starAVG,
      this.eveluateCount,
      this.sold});

  ProductModel copyWith(
      {String id,
      List<String> image,
      int status,
      double weight,
      double price,
      int quantity,
      String name,
      String detail,
      GroupProduct groupProduct,
      int number,
      int starAVG,
      int eveluateCount,
      int sold}) {
    return ProductModel(
        id: id ?? this.id,
        image: image ?? this.image,
        status: status ?? this.status,
        weight: weight ?? this.weight,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        name: name ?? this.name,
        detail: detail ?? this.detail,
        groupProduct: groupProduct ?? this.groupProduct,
        number: number ?? this.number,
        starAVG: starAVG ?? this.starAVG,
        eveluateCount: eveluateCount ?? this.eveluateCount,
        sold: sold ?? this.sold);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'status': status,
      'weight': weight,
      'price': price,
      'quantity': quantity,
      'name': name,
      'detail': detail,
      'groupProduct': groupProduct.toMap(),
      'number': number,
      'starAVG': starAVG,
      'eveluateCount': eveluateCount,
      'sold': sold
    };
  }

  Map<String, dynamic> toMap1() {
    return {
      'id': id,
      'image': image,
      'status': status,
      'weight': weight,
      'price': price,
      'quantity': quantity,
      'name': name,
      'detail': detail,
      'number': number,
      'starAVG': starAVG,
      'eveluateCount': eveluateCount,
      'sold': sold
    };
  }

  Map<String, dynamic> toMapCart() {
    return {
      '_id': id,
      'image': image,
      'status': status,
      'weight': weight,
      'cost': price,
      'name': name,
      'detail': detail,
      'quantity': number,
      'starAVG': starAVG,
      'eveluateCount': eveluateCount,
      'sold': sold
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'],
      image: (map['image'] as List<dynamic>).map((e) => e.toString()).toList(),
      status: map['status'],
      weight: double.tryParse((map['weight'] ?? 0).toString()),
      price: double.tryParse((map['price'] ?? 0).toString()),
      quantity: map['quantity'],
      name: map['name'],
      detail: map['detail'],
      groupProduct: GroupProduct.fromMap(map['groupProduct']),
      starAVG: double.tryParse((map['starAVG'] ?? 0).toString()),
      eveluateCount: map['eveluateCount'],
      sold: map['sold'],
    );
  }
  factory ProductModel.fromMap1(Map<String, dynamic> map) {
    return ProductModel(
      id: map['_id'],
      image: (map['image'] as List<dynamic>).map((e) => e.toString()).toList(),
      status: map['status'],
      weight: double.tryParse((map['weight'] ?? 0).toString()),
      price: double.tryParse((map['price'] ?? 0).toString()),
      quantity: map['quantity'],
      name: map['name'],
      detail: map['detail'],
    );
  }
  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, image: $image, status: $status, weight: $weight, price: $price, quantity: $quantity, name: $name, detail: $detail, groupProduct: $groupProduct, number: $number, starAVG: $starAVG, eveluateCount: $eveluateCount,sold: $sold)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        listEquals(other.image, image) &&
        other.status == status &&
        other.weight == weight &&
        other.price == price &&
        other.quantity == quantity &&
        other.name == name &&
        other.detail == detail &&
        other.groupProduct == groupProduct &&
        other.number == number &&
        other.starAVG == starAVG &&
        other.eveluateCount == eveluateCount &&
        other.sold == sold;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        status.hashCode ^
        weight.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        name.hashCode ^
        detail.hashCode ^
        groupProduct.hashCode ^
        number.hashCode ^
        starAVG.hashCode ^
        eveluateCount.hashCode ^
        sold.hashCode;
  }
}
