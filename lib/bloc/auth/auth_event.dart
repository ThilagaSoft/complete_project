import 'package:flutter/cupertino.dart';
import 'package:map_pro/model/country_model.dart';

abstract class AuthEvent {}

class RegisterEvent extends AuthEvent
{
  final String userName;
  final String email;
  final String phone;
  final String password;
  final Country countryData;

  RegisterEvent({
    required this.userName,
    required this.email,
    required this.phone,
    required this.password,
    required this.countryData,
  });
}
class LoginEvent extends AuthEvent
{
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
  });
}
class SubmitEvent extends AuthEvent
{
}

