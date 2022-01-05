import 'dart:convert';

class AddressModel {
  final String id;
  String customerId;
  String name;
  String phone;
  String province;
  String district;
  String address;
  bool isMain;
  AddressModel({
    this.id,
    this.customerId,
    this.name,
    this.phone,
    this.province,
    this.district,
    this.address,
    this.isMain,
  });

  AddressModel copyWith({
    String id,
    String customerId,
    String name,
    String phone,
    String province,
    String district,
    String address,
    bool isMain,
  }) {
    return AddressModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      province: province ?? this.province,
      district: district ?? this.district,
      address: address ?? this.address,
      isMain: isMain ?? this.isMain,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'name': name,
      'phone': phone,
      'province': province,
      'district': district,
      'address': address,
      'isMain': isMain,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['_id'],
      customerId: map['customerId'],
      name: map['name'],
      phone: map['phone'],
      province: map['province'],
      district: map['district'],
      address: map['address'],
      isMain: map['isMain'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AddressModel(id: $id, customerId: $customerId, name: $name, phone: $phone, province: $province, district: $district, address: $address, isMain: $isMain)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.id == id &&
        other.customerId == customerId &&
        other.name == name &&
        other.phone == phone &&
        other.province == province &&
        other.district == district &&
        other.address == address &&
        other.isMain == isMain;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        province.hashCode ^
        district.hashCode ^
        address.hashCode ^
        isMain.hashCode;
  }
}
