import 'dart:convert';

import 'package:flutter/foundation.dart';

class MessageModel {
  String id;
  String creatorUser;
  List<String> seenByUser;
  bool isDelete;
  String message;
  String idRoom;
  DateTime createdAt;
  DateTime updatedAt;
  MessageModel({
    this.id,
    this.creatorUser,
    this.seenByUser,
    this.isDelete,
    this.message,
    this.idRoom,
    this.createdAt,
    this.updatedAt,
  });

  MessageModel copyWith({
    String id,
    String creatorUser,
    List<String> seenByUser,
    bool isDelete,
    String message,
    String idRoom,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      creatorUser: creatorUser ?? this.creatorUser,
      seenByUser: seenByUser ?? this.seenByUser,
      isDelete: isDelete ?? this.isDelete,
      message: message ?? this.message,
      idRoom: idRoom ?? this.idRoom,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'creatorUser': creatorUser,
      'seenByUser': seenByUser,
      'isDelete': isDelete,
      'message': message,
      'idRoom': idRoom,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['_id'],
      creatorUser: map['creatorUser'],
      seenByUser: List<String>.from(map['seenByUser']),
      isDelete: map['isDelete'],
      message: map['message'],
      idRoom: map['idRoom'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id, creatorUser: $creatorUser, seenByUser: $seenByUser, isDelete: $isDelete, message: $message, idRoom: $idRoom, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.id == id &&
        other.creatorUser == creatorUser &&
        listEquals(other.seenByUser, seenByUser) &&
        other.isDelete == isDelete &&
        other.message == message &&
        other.idRoom == idRoom &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        creatorUser.hashCode ^
        seenByUser.hashCode ^
        isDelete.hashCode ^
        message.hashCode ^
        idRoom.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
