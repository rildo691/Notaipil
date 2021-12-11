// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
    Student({
        this.process,
        this.statusForm,
        this.personalDataId,
        this.courseId,
        this.gradeId,
    });

    String? process;
    int? statusForm;
    String? personalDataId;
    String? courseId;
    String? gradeId;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        process: json["process"],
        statusForm: json["statusForm"],
        personalDataId: json["personalDataId"],
        courseId: json["courseId"],
        gradeId: json["gradeId"],
    );

    Map<String, dynamic> toJson() => {
        "process": process,
        "statusForm": statusForm,
        "personalDataId": personalDataId,
        "courseId": courseId,
        "gradeId": gradeId,
    };
}
