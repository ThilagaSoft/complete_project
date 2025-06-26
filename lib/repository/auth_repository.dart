
import 'dart:convert';

import 'package:map_pro/database/local_db.dart';
import 'package:map_pro/model/country_model.dart';
import 'package:map_pro/model/user_model.dart';

class AuthRepository

{  final LocalDatabase db = LocalDatabase.instance;


Future<UserModel?> register(
      String username,
      String email,
      String phone,
      String password,
      Country countryData,
      ) async {
    final existing = await db.getUserModelByEmail(email);
    if (existing != null)
    {
      throw Exception("User already exists");
    }

    final user =
    {
      "userName":username,
      "email":email,
      "mobile":phone,
      "password":password,
      'countryData': jsonEncode(countryData.toJson()),

    };

    final id = await db.insertUserModel(user);
    final userData = await db.getUserModelById(id);
    return userData;

}


Future<UserModel?> login(String email, String password) async {
  print("🔑 Login attempt: $email / $password");
  final user = await db.getUserModelByEmail(email);

  if (user == null)
  {
    print("❌ User not found");
    throw Exception("User not found");
  }

  print("✅ User found: ${user.email} / ${user.password}");

  if (user.password != password)
  {
    print("❌ Password mismatch: expected ${user.password}, got $password");
    throw Exception("Invalid password");
  }

  print("🎉 Login successful");
  return user;
}

}
