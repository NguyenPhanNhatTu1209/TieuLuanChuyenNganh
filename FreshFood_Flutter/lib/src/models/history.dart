import 'dart:convert';

import 'package:flutter/foundation.dart';

class HistoryModel {
  final String id;
  String title;
  DateTime createdAt;

  HistoryModel({
    this.id,
    this.title,
    this.createdAt,
  });

  HistoryModel copyWith({
    String id,
    String title,
    DateTime createdAt,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'],
      title: map['title'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
  // factory HistoryModel.fromMap1(Map<String, dynamic> map) {
  //   return HistoryModel(
  //     id: map['id'],
  //     title: map['title'],
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromJson(String source) =>
      HistoryModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'HistoryModel(id: $id, title: $title, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryModel &&
        other.id == id &&
        other.title == title &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ createdAt.hashCode;
}
