// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {

  String? email;
  String? password;
  bool? isActive;

  UserModel({
    this.email,
    this.password,
    this.isActive,
  });

    

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    password: json["password"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "isActive": isActive,
  };
}
