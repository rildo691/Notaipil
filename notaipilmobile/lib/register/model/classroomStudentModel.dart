// To parse this JSON data, do
//
//     final classroomStudentModel = classroomStudentModelFromJson(jsonString);

import 'dart:convert';

ClassroomStudentModel classroomStudentModelFromJson(String str) => ClassroomStudentModel.fromJson(json.decode(str));

String classroomStudentModelToJson(ClassroomStudentModel data) => json.encode(data.toJson());

class ClassroomStudentModel {
    ClassroomStudentModel({
        this.studentId,
        this.classroomId,
    });

    int? studentId;
    String? classroomId;

    factory ClassroomStudentModel.fromJson(Map<String, dynamic> json) => ClassroomStudentModel(
        studentId: json["studentId"],
        classroomId: json["classroomId"],
    );

    Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "classroomId": classroomId,
    };
}
