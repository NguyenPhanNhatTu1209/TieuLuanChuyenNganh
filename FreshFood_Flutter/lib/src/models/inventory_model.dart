import 'dart:convert';

class InventoryModel {
  final String id;
  String name;
  int price;
  int priceDiscount;
  int quantity;
  InventoryModel({
    this.id,
    this.name,
    this.price,
    this.priceDiscount,
    this.quantity,
  });

  factory InventoryModel.fromMap(Map<String, dynamic> map) {
    return InventoryModel(
      id: map['_id'],
      name: map['name'],
      price: map['price'],
      priceDiscount: map['priceDiscount'],
      quantity: map['quantityChange'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'priceDiscount': priceDiscount,
      'quantity': quantity,
    };
  }
}
