import 'dart:convert';

class GroupQuestionModel {
  String id;
  String title;
  bool isActive;
  DateTime createdAt;
  DateTime updatedAt;
  int numberQuestion;
  GroupQuestionModel({
    this.id,
    this.title,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.numberQuestion,
  });

  GroupQuestionModel copyWith({
    String id,
    String title,
    bool isActive,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return GroupQuestionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isActive': isActive,
      'numberQuestion': numberQuestion,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory GroupQuestionModel.fromMap(Map<String, dynamic> map) {
    return GroupQuestionModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isActive: map['isActive'] ?? false,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      numberQuestion: map['numberQuestion'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupQuestionModel.fromJson(String source) =>
      GroupQuestionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GroupQuestionModel(id: $id, title: $title, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupQuestionModel &&
        other.id == id &&
        other.title == title &&
        other.isActive == isActive &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        isActive.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
