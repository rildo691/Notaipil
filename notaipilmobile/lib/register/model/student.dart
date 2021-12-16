// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
    Student({
        this.bi,
        this.fullName,
        this.birthdate,
        this.gender,
        this.process,
        this.courseId,
        this.gradeId,
    });

    String? bi;
    String? fullName;
    String? birthdate;
    String? gender;
    int? process;
    String? courseId;
    String? gradeId;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        bi: json["bi"],
        fullName: json["fullName"],
        birthdate: json["birthdate"],
        gender: json["gender"],
        process: json["process"],
        courseId: json["courseId"],
        gradeId: json["gradeId"],
    );

    Map<String, dynamic> toJson() => {
        "bi": bi,
        "fullName": fullName,
        "birthdate": brithdate,
        "gender": gender,
        "process": process,
        "courseId": courseId,
        "gradeId": gradeId,
    };
}
