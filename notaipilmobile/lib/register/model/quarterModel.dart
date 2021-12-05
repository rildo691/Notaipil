// To parse this JSON data, do
//
//     final quarterModel = quarterModelFromJson(jsonString);

import 'dart:convert';

QuarterModel quarterModelFromJson(String str) => QuarterModel.fromJson(json.decode(str));

String quarterModelToJson(QuarterModel data) => json.encode(data.toJson());

class QuarterModel {

  String? name;

  QuarterModel({
    this.name,
  });

    

  factory QuarterModel.fromJson(Map<String, dynamic> json) => QuarterModel(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
