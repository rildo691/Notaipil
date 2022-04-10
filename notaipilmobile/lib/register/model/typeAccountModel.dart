// To parse this JSON data, do
//
//     final typeAccountModel = typeAccountModelFromJson(jsonString);

import 'dart:convert';

TypeAccountModel typeAccountModelFromJson(String str) => TypeAccountModel.fromJson(json.decode(str));

String typeAccountModelToJson(TypeAccountModel data) => json.encode(data.toJson());

class TypeAccountModel {

  String? name;
  String? id;

  TypeAccountModel({
    this.name,
    this.id
  });

    

  factory TypeAccountModel.fromJson(Map<String, dynamic> json) => TypeAccountModel(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
