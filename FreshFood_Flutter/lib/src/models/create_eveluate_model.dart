import 'dart:convert';

import 'package:get/get.dart';

class CreateEveluateModel extends GetxController {
  int star;
  String content;
  String productId;
  String orderId;
  CreateEveluateModel({
    this.star,
    this.content,
    this.productId,
    this.orderId,
  });

  CreateEveluateModel copyWith({
    int star,
    String content,
    String productId,
    String orderId,
  }) {
    return CreateEveluateModel(
      star: star ?? this.star,
      content: content ?? this.content,
      productId: productId ?? this.productId,
      orderId: orderId ?? this.orderId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'star': star,
      'content': content,
      'productId': productId,
      'orderId': orderId,
    };
  }

  factory CreateEveluateModel.fromMap(Map<String, dynamic> map) {
    return CreateEveluateModel(
      star: map['star'],
      content: map['content'],
      productId: map['productId'],
      orderId: map['orderId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateEveluateModel.fromJson(String source) =>
      CreateEveluateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EveluateModel(star: $star, content: $content, productId: $productId, orderId: $orderId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateEveluateModel &&
        other.star == star &&
        other.content == content &&
        other.productId == productId &&
        other.orderId == orderId;
  }

  @override
  int get hashCode {
    return star.hashCode ^
        content.hashCode ^
        productId.hashCode ^
        orderId.hashCode;
  }
}
