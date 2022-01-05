import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CartModel extends GetxController {
  final String id;
  List<String> image;
  int status = 0;
  double cost;
  int quantity;
  String name;
  String detail;
  String nameGroup;
  int selected;
  double weight;
  CartModel({
    this.id,
    this.image,
    this.status,
    this.cost,
    this.quantity,
    this.name,
    this.detail,
    this.nameGroup,
    this.selected = 0,
    this.weight,
  });

  CartModel copyWith({
    String id,
    List<String> image,
    int status,
    double cost,
    int quantity,
    String name,
    String detail,
    String nameGroup,
    int selected,
    double weight,
  }) {
    return CartModel(
      id: id ?? this.id,
      image: image ?? this.image,
      status: status ?? this.status,
      cost: cost ?? this.cost,
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
      detail: detail ?? this.detail,
      nameGroup: nameGroup ?? this.nameGroup,
      selected: selected ?? this.selected,
      weight: weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'status': status,
      'cost': cost,
      'quantity': quantity,
      'name': name,
      'detail': detail,
      'nameGroup': nameGroup,
      'selected': selected,
      'weight': weight,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['_id'],
      image: List<String>.from(map['image']),
      status: map['status'],
      cost: double.tryParse((map['cost'] ?? 0).toString()),
      quantity: map['quantity'],
      name: map['name'],
      detail: map['detail'],
      nameGroup: map['nameGroup'],
      selected: map['selected'],
      weight: double.tryParse((map['weight'] ?? 0).toString()),
    );
  }
  factory CartModel.fromMapCart(Map<String, dynamic> map) {
    return CartModel(
        id: map['productId'],
        image: List<String>.from(map['image']),
        status: map['status'],
        cost: double.tryParse((map['price'] ?? 0).toString()),
        quantity: map['quantity'],
        name: map['name'],
        detail: map['detail'],
        nameGroup: map['nameGroup'],
        weight: double.tryParse((map['weight'] ?? 0).toString()),
        selected: map['selected']);
  }
  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartModel(id: $id, image: $image, status: $status, cost: $cost, quantity: $quantity, name: $name, detail: $detail, nameGroup: $nameGroup, selected: $selected, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartModel &&
        other.id == id &&
        listEquals(other.image, image) &&
        other.status == status &&
        other.cost == cost &&
        other.quantity == quantity &&
        other.name == name &&
        other.detail == detail &&
        other.nameGroup == nameGroup &&
        other.selected == selected &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        status.hashCode ^
        cost.hashCode ^
        quantity.hashCode ^
        name.hashCode ^
        detail.hashCode ^
        nameGroup.hashCode ^
        selected.hashCode ^
        weight.hashCode;
  }

  incrementQuantity() {
    if (this.quantity >= 10) {
      this.quantity = 10;
    } else {
      this.quantity += 1;
    }
  }

  decrementQuantity() {
    if (this.quantity <= 1) {
      this.quantity = 1;
    } else {
      this.quantity -= 1;
    }
    update();
  }
}
