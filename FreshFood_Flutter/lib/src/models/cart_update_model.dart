import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CartUpdateModel extends GetxController {
  final String id;
  int quantity;
  int status;
  CartUpdateModel({
    this.id,
    this.quantity,
    this.status,
  });

  CartUpdateModel copyWith({
    String id,
    int quantity,
    int status,
  }) {
    return CartUpdateModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'status': status,
    };
  }

  factory CartUpdateModel.fromMap(Map<String, dynamic> map) {
    return CartUpdateModel(
      id: map['_id'],
      quantity: map['quantity'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartUpdateModel.fromJson(String source) =>
      CartUpdateModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CartUpdateModel(id: $id, quantity: $quantity, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartUpdateModel &&
        other.id == id &&
        other.quantity == quantity &&
        other.status == status;
  }

  @override
  int get hashCode => id.hashCode ^ quantity.hashCode ^ status.hashCode;
}
