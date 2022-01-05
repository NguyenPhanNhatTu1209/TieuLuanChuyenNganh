import 'dart:convert';

class UserModel {
  final String id;
  int role;
  String fcm;
  String email;
  String phone;
  String name;
  String avatar;
  String token;
  UserModel(
      {this.id,
      this.role,
      this.fcm,
      this.email,
      this.phone,
      this.name,
      this.avatar,
      this.token});
  factory UserModel.fromLogin(Map<String, dynamic> data) {
    return UserModel(
      token: data['token'],
      // role: data['role'],
    );
  }
  UserModel copyWith({
    String id,
    int role,
    String fcm,
    String email,
    String phone,
    String name,
    String avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      role: role ?? this.role,
      fcm: fcm ?? this.fcm,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'role': role,
      'fcm': fcm,
      'email': email,
      'phone': phone,
      'name': name,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'],
      role: map['role'],
      fcm: map['fcm'],
      email: map['email'],
      phone: map['phone'],
      name: map['name'],
      avatar: map['avatar'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, role: $role, fcm: $fcm, email: $email, phone: $phone, name: $name, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.role == role &&
        other.fcm == fcm &&
        other.email == email &&
        other.phone == phone &&
        other.name == name &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        role.hashCode ^
        fcm.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        name.hashCode ^
        avatar.hashCode;
  }
}
