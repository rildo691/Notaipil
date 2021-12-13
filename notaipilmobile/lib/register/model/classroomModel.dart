// To parse this JSON data, do
//
//     final classroomModel = classroomModelFromJson(jsonString);

import 'dart:convert';

ClassroomModel classroomModelFromJson(String str) => ClassroomModel.fromJson(json.decode(str));

String classroomModelToJson(ClassroomModel data) => json.encode(data.toJson());

class ClassroomModel {
    ClassroomModel({
        this.id,
        this.name,
        this.room,
        this.code,
        this.gradeId,
        this.courseId,
        this.academicYearId,
    });

    String? id;
    String? name;
    String? room;
    String? code;
    String? gradeId;
    String? courseId;
    String? academicYearId;

    factory ClassroomModel.fromJson(Map<String, dynamic> json) => ClassroomModel(
        id: json["id"],
        name: json["name"],
        room: json["room"],
        code: json["code"],
        gradeId: json["gradeId"],
        courseId: json["courseId"],
        academicYearId: json["academicYearId"],
    );

    Map<String, dynamic> toJson() => {
        "room": room,
        "code": code,
        "gradeId": gradeId,
        "courseId": courseId,
        "academicYearId": academicYearId,
    };
}
