import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

class RoomModel {
  String idRoom;
  String name;
  List<String> seenByUser;
  String message;
  String avatar;
  DateTime updatedAt;
  RoomModel({
    this.idRoom,
    this.name,
    this.seenByUser,
    this.message,
    this.avatar,
    this.updatedAt,
  });

  RoomModel copyWith({
    String idRoom,
    String name,
    List<String> seenByUser,
    String message,
    String avatar,
    DateTime updatedAt,
  }) {
    return RoomModel(
      idRoom: idRoom ?? this.idRoom,
      name: name ?? this.name,
      seenByUser: seenByUser ?? this.seenByUser,
      message: message ?? this.message,
      avatar: avatar ?? this.avatar,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idRoom': idRoom,
      'name': name,
      'seenByUser': seenByUser,
      'message': message,
      'avatar': avatar,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      idRoom: map['idRoom'] ?? '',
      name: map['name'] ?? '',
      seenByUser: List<String>.from(map['seenByUser']),
      message: map['message'] ?? '',
      avatar: map['avatar'] ?? '',
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(idRoom: $idRoom, name: $name, seenByUser: $seenByUser, message: $message, avatar: $avatar, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is RoomModel &&
        other.idRoom == idRoom &&
        other.name == name &&
        listEquals(other.seenByUser, seenByUser) &&
        other.message == message &&
        other.avatar == avatar &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return idRoom.hashCode ^
        name.hashCode ^
        seenByUser.hashCode ^
        message.hashCode ^
        avatar.hashCode ^
        updatedAt.hashCode;
  }
}
