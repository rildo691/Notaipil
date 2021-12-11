// To parse this JSON data, do
//
//     final teacher = teacherFromJson(jsonString);

import 'dart:convert';

Teacher teacherFromJson(String str) => Teacher.fromJson(json.decode(str));

String teacherToJson(Teacher data) => json.encode(data.toJson());

class Teacher {
    Teacher({
        this.diretor,
        this.teacherAccountId,
    });

    bool? diretor;
    String? teacherAccountId;

    factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        diretor: json["diretor"],
        teacherAccountId: json["teacherAccountId"],
    );

    Map<String, dynamic> toJson() => {
        "diretor": diretor,
        "teacherAccountId": teacherAccountId,
    };
}
