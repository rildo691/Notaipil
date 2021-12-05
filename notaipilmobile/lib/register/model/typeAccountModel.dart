// To parse this JSON data, do
//
//     final typeAccountModel = typeAccountModelFromJson(jsonString);

import 'dart:convert';

TypeAccountModel typeAccountModelFromJson(String str) => TypeAccountModel.fromJson(json.decode(str));

String typeAccountModelToJson(TypeAccountModel data) => json.encode(data.toJson());

class TypeAccountModel {

  String? description;

  TypeAccountModel({
    this.description,
  });

    

  factory TypeAccountModel.fromJson(Map<String, dynamic> json) => TypeAccountModel(
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
  };
}
