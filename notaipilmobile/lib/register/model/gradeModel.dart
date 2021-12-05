// To parse this JSON data, do
//
//     final gradeModel = gradeModelFromJson(jsonString);

import 'dart:convert';

GradeModel gradeModelFromJson(String str) => GradeModel.fromJson(json.decode(str));

String gradeModelToJson(GradeModel data) => json.encode(data.toJson());

class GradeModel {

  String? grade;

  GradeModel({
    this.grade,
  });

    
  factory GradeModel.fromJson(Map<String, dynamic> json) => GradeModel(
    grade: json["grade"],
  );

  Map<String, dynamic> toJson() => {
    "grade": grade,
  };
}
