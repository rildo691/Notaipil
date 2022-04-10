// To parse this JSON data, do
//
//     final classroomStudentModel = classroomStudentModelFromJson(jsonString);

import 'dart:convert';

ClassroomStudentModel classroomStudentModelFromJson(String str) => ClassroomStudentModel.fromJson(json.decode(str));

String classroomStudentModelToJson(ClassroomStudentModel data) => json.encode(data.toJson());

class ClassroomStudentModel {
    ClassroomStudentModel({
        this.number,
        this.studentId,
        this.classroomId,
    });

    int?  number;
    int? studentId;
    String? classroomId;

    factory ClassroomStudentModel.fromJson(Map<String, dynamic> json) => ClassroomStudentModel(
        number: json["number"],
        studentId: json["studentId"],
        classroomId: json["classroomId"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "studentId": studentId,
        "classroomId": classroomId,
    };
}
