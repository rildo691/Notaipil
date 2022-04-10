// To parse this JSON data, do
//
//     final teacher = teacherFromJson(jsonString);

import 'dart:convert';

Teacher teacherFromJson(String str) => Teacher.fromJson(json.decode(str));

String teacherToJson(Teacher data) => json.encode(data.toJson());

class Teacher {
    Teacher({
        this.teacherAccountId,
    });

    String? teacherAccountId;

    factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        teacherAccountId: json["teacherAccountId"],
    );

    Map<String, dynamic> toJson() => {
        "teacherAccountId": teacherAccountId,
    };
}
