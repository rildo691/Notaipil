// To parse this JSON data, do
//
//     final area = areaFromJson(jsonString);

import 'dart:convert';

AreaModel areaFromJson(String str) => AreaModel.fromJson(json.decode(str));

String areaToJson(AreaModel data) => json.encode(data.toJson());

class AreaModel {
  String? id;
  String? name;

  AreaModel({
    this.id,
    this.name,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,    
  };
}
