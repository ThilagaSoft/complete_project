import 'dart:convert';
import 'package:map_pro/model/country_model.dart';


class UserRequestModel {
  final int? id;
  final String userName;
  final String mobile;
  final String email;
  final String password;
  final Country countryData;

  UserRequestModel({
    this.id,
    required this.userName,
    required this.mobile,
    required this.email,
    required this.password,
    required this.countryData,
  });

  factory UserRequestModel.fromMap(Map<String, dynamic> map) {
    return UserRequestModel(
      id: map['id'],
      userName: map['userName'],
      mobile: map['mobile'],
      email: map['email'],
      password: map['password'],
      countryData: Country.fromJson(jsonDecode(map['countryData'])),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'mobile': mobile,
      'email': email,
      'password': password,
      'countryData': jsonEncode(countryData),
    };
  }
}
