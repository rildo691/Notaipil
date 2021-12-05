// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'dart:convert';

SubjectModel subjectModelFromJson(String str) => SubjectModel.fromJson(json.decode(str));

String subjectModelToJson(SubjectModel data) => json.encode(data.toJson());

class SubjectModel {

  String? subject;
  String? category;

  SubjectModel({
    this.subject,
    this.category,
  });

    

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    subject: json["subject"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "subject": subject,
    "category": category,
  };
}