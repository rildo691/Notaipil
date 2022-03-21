// To parse this JSON data, do
//
//     final studentGrade = studentGradeFromJson(jsonString);

import 'dart:convert';

StudentGradeModel studentGradeFromJson(String str) => StudentGradeModel.fromJson(json.decode(str));

String studentGradeToJson(StudentGradeModel data) => json.encode(data.toJson());

class StudentGradeModel {
    StudentGradeModel({
        this.data,
    });

    List<Datum>? data;

    factory StudentGradeModel.fromJson(Map<String, dynamic> json) => StudentGradeModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.mac,
        this.pp,
        this.pt,
        this.teacherInClassroomId,
        this.classroomStudentId,
    });

    int? mac;
    int? pp;
    int? pt;
    String? quarterId;
    String? teacherInClassroomId;
    String? classroomStudentId;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        mac: json["mac"],
        pp: json["pp"],
        pt: json["pt"],
        teacherInClassroomId: json["teacherInClassroomId"],
        classroomStudentId: json["classroomStudentId"],
    );

    Map<String, dynamic> toJson() => {
        "mac": mac,
        "pp": pp,
        "pt": pt,
        "teacherInClassroomId": teacherInClassroomId,
        "classroomStudentId": classroomStudentId,
    };
}
