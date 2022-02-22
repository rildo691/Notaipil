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
        this.process
    });

    String? bi;
    String? fullName;
    String? birthdate;
    String? gender;
    int? process;

    factory Student.fromJson(Map<String, dynamic> json) => Student(
        bi: json["bi"],
        fullName: json["fullName"],
        birthdate: json["birthdate"],
        gender: json["gender"],
        process: json["process"],
    );

    Map<String, dynamic> toJson() => {
        "bi": bi,
        "fullName": fullName,
        "birthdate": birthdate,
        "gender": gender,
        "process": process,
    };
}
