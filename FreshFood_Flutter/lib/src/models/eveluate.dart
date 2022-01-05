import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EveluateModel extends GetxController {
  final String id;
  List<String> image;
  int star;
  String content;
  String productId;
  String customerId;
  String orderId;
  String avatar;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  EveluateModel({
    this.id,
    this.image,
    this.star,
    this.content,
    this.productId,
    this.customerId,
    this.orderId,
    this.avatar,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  EveluateModel copyWith({
    String id,
    List<String> image,
    int star,
    String content,
    String productId,
    String customerId,
    String orderId,
    String avatar,
    String name,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return EveluateModel(
      id: id ?? this.id,
      image: image ?? this.image,
      star: star ?? this.star,
      content: content ?? this.content,
      productId: productId ?? this.productId,
      customerId: customerId ?? this.customerId,
      orderId: orderId ?? this.orderId,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'star': star,
      'content': content,
      'productId': productId,
      'customerId': customerId,
      'orderId': orderId,
      'avatar': avatar,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory EveluateModel.fromMap(Map<String, dynamic> map) {
    return EveluateModel(
      id: map['_id'],
      image: List<String>.from(map['image']),
      star: map['star'],
      content: map['content'],
      productId: map['productId'],
      customerId: map['customerId'],
      orderId: map['orderId'],
      avatar: map['avatar'],
      name: map['name'],
      // createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      // updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }
  factory EveluateModel.fromMap1(Map<String, dynamic> map) {
    return EveluateModel(
      image: List<String>.from(map['image']),
      star: map['star'],
      content: map['content'],
      productId: map['productId'],
      orderId: map['orderId'],
      name: map['name'],
      // createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      // updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EveluateModel.fromJson(String source) =>
      EveluateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EveluateModel(id: $id, image: $image, star: $star, content: $content, productId: $productId, customerId: $customerId, orderId: $orderId, avatar: $avatar, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EveluateModel &&
        other.id == id &&
        listEquals(other.image, image) &&
        other.star == star &&
        other.content == content &&
        other.productId == productId &&
        other.customerId == customerId &&
        other.orderId == orderId &&
        other.avatar == avatar &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        star.hashCode ^
        content.hashCode ^
        productId.hashCode ^
        customerId.hashCode ^
        orderId.hashCode ^
        avatar.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
