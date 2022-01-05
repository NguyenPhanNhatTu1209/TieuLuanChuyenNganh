import 'dart:convert';

class GroupProduct {
  String name;
  String key;
  GroupProduct({
    this.name,
    this.key,
  });

  GroupProduct copyWith({
    String name,
    String key,
  }) {
    return GroupProduct(
      name: name ?? this.name,
      key: key ?? this.key,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'key': key,
    };
  }

  factory GroupProduct.fromMap(Map<String, dynamic> map) {
    return GroupProduct(
      name: map['name'],
      key: map['key'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupProduct.fromJson(String source) =>
      GroupProduct.fromMap(json.decode(source));

  @override
  String toString() => 'Product(name: $name, key: $key)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupProduct && other.name == name && other.key == key;
  }

  @override
  int get hashCode => name.hashCode ^ key.hashCode;
}
