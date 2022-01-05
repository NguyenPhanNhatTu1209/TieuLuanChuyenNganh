import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductOrderModel {
  String id;
  List<String> image;
  double weight;
  double price;
  int quantity;
  String name;
  String nameGroup;
  String productId;
  ProductOrderModel({
    this.id,
    this.image,
    this.weight,
    this.price,
    this.quantity,
    this.name,
    this.nameGroup,
    this.productId,
  });

  ProductOrderModel copyWith({
    String id,
    List<String> image,
    double weight,
    double price,
    int quantity,
    String name,
    String nameGroup,
    String productId,
  }) {
    return ProductOrderModel(
      id: id ?? this.id,
      image: image ?? this.image,
      weight: weight ?? this.weight,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
      nameGroup: nameGroup ?? this.nameGroup,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'weight': weight,
      'price': price,
      'quantity': quantity,
      'name': name,
      'nameGroup': nameGroup,
      'productId': productId,
    };
  }

  factory ProductOrderModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderModel(
      id: map['_id'],
      image: List<String>.from(map['image']),
      weight: double.tryParse((map['weight'] ?? 0).toString()),
      price: double.tryParse((map['price'] ?? 0).toString()),
      quantity: map['quantity'],
      name: map['name'],
      nameGroup: map['nameGroup'],
      productId: map['productId'],
    );
  }

  factory ProductOrderModel.fromMap1(Map<String, dynamic> map) {
    return ProductOrderModel(
      id: map['_id'],
      image: List<String>.from(map['image']),
      weight: double.tryParse((map['weight'] ?? 0).toString()),
      price: double.tryParse((map['price'] ?? 0).toString()),
      quantity: map['quantity'],
      name: map['name'],
      nameGroup: map['nameGroup'],
      productId: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductOrderModel.fromJson(String source) =>
      ProductOrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductOrderModel(id: $id, image: $image, weight: $weight, price: $price, quantity: $quantity, name: $name, nameGroup: $nameGroup, productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductOrderModel &&
        other.id == id &&
        listEquals(other.image, image) &&
        other.weight == weight &&
        other.price == price &&
        other.quantity == quantity &&
        other.name == name &&
        other.nameGroup == nameGroup &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        weight.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        name.hashCode ^
        nameGroup.hashCode ^
        productId.hashCode;
  }
}
