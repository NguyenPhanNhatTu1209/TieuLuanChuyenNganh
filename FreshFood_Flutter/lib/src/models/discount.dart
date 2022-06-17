import 'dart:convert';

import 'package:get/get.dart';

class DiscountModel extends GetxController {
  String id;
  String idProduct;
  String idGroupProduct;
  bool totalProduct;
  int percentDiscount;
  int minimumDiscount;
  int maxDiscount;
  DateTime duration;
  int quantity;
  int used;
  bool active;
  DiscountModel({
    this.id,
    this.idProduct,
    this.idGroupProduct,
    this.totalProduct,
    this.percentDiscount,
    this.maxDiscount,
    this.duration,
    this.minimumDiscount,
    this.quantity,
    this.used,
    this.active,
  });

  DiscountModel copyWith({
    String id,
    String idProduct,
    String idGroupProduct,
    bool totalProduct,
    int percentDiscount,
    int maxDiscount,
    DateTime duration,
    int minimumDiscount,
  }) {
    return DiscountModel(
      id: id ?? this.id,
      idProduct: idProduct ?? this.idProduct,
      idGroupProduct: idGroupProduct ?? this.idGroupProduct,
      totalProduct: totalProduct ?? this.totalProduct,
      percentDiscount: percentDiscount ?? this.percentDiscount,
      maxDiscount: maxDiscount ?? this.maxDiscount,
      duration: duration ?? this.duration,
      minimumDiscount: minimumDiscount ?? this.minimumDiscount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idProduct': idProduct,
      'idGroupProduct': idGroupProduct,
      'totalProduct': totalProduct,
      'percentDiscount': percentDiscount,
      'maxDiscount': maxDiscount,
      'duration': duration.millisecondsSinceEpoch,
      'minimumDiscount': minimumDiscount,
      'quantity': quantity,
      'used': used,
      'active': active
    };
  }

  factory DiscountModel.fromMap(Map<String, dynamic> map) {
    return DiscountModel(
        id: map['_id'] ?? '',
        idProduct: map['idProduct'] ?? '',
        idGroupProduct: map['idGroupProduct'] ?? '',
        totalProduct: map['totalProduct'] ?? false,
        percentDiscount: map['percentDiscount']?.toInt() ?? 0,
        minimumDiscount: map['minimumDiscount']?.toInt() ?? 0,
        maxDiscount: map['maxDiscount']?.toInt() ?? 0,
        duration: DateTime.parse(map['duration']),
        quantity: map['quantity']?.toInt() ?? 0,
        used: map['used']?.toInt() ?? 0,
        active: map['active'] ?? false);
  }

  String toJson() => json.encode(toMap());

  factory DiscountModel.fromJson(String source) =>
      DiscountModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateEveluateModel(id: $id, idProduct: $idProduct, idGroupProduct: $idGroupProduct, totalProduct: $totalProduct, percentDiscount: $percentDiscount, maxDiscount: $maxDiscount, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiscountModel &&
        other.id == id &&
        other.idProduct == idProduct &&
        other.idGroupProduct == idGroupProduct &&
        other.totalProduct == totalProduct &&
        other.percentDiscount == percentDiscount &&
        other.maxDiscount == maxDiscount &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idProduct.hashCode ^
        idGroupProduct.hashCode ^
        totalProduct.hashCode ^
        percentDiscount.hashCode ^
        maxDiscount.hashCode ^
        duration.hashCode;
  }
}
