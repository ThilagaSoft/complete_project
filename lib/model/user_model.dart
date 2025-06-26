import 'dart:convert';
import 'package:map_pro/model/country_model.dart';

class UserModel {
  final int id;
  final String userName;
  final String mobile;
  final String email;
  final Country countryData;
  final String password;

  UserModel({
    required this.id,
    required this.userName,
    required this.mobile,
    required this.email,
    required this.countryData,
    required this.password,
  });

  UserModel copyWith({
    int? id,
    String? userName,
    String? mobile,
    String? email,
    Country? countryData,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      countryData: countryData ?? this.countryData,
      password: password ?? this.password,
    );
  }

  /// Used when reading from database
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      userName: json['userName'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
      countryData: Country.fromJson(jsonDecode(json['countryData'])),
      password: json['password'] as String,
    );
  }

  /// Used when saving to database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'mobile': mobile,
      'email': email,
      'password': password,
      'countryData': jsonEncode(countryData.toJson()), // ✅ SERIALIZED
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, userName: $userName, mobile: $mobile, email: $email, countryData: $countryData, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.userName == userName &&
        other.mobile == mobile &&
        other.email == email &&
        other.countryData == countryData &&
        other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    userName.hashCode ^
    mobile.hashCode ^
    email.hashCode ^
    countryData.hashCode ^
    password.hashCode;
  }
}
