// To parse this JSON data, do
//
//     final gradeModel = gradeModelFromJson(jsonString);

import 'dart:convert';

GradeModel gradeModelFromJson(String str) => GradeModel.fromJson(json.decode(str));

String gradeModelToJson(GradeModel data) => json.encode(data.toJson());

class GradeModel {
  String? id;
  String? name;

  GradeModel({
    this.id,
    this.name,
  });

    
  factory GradeModel.fromJson(Map<String, dynamic> json) => GradeModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
