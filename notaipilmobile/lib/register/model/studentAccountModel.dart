// To parse this JSON data, do
//
//     final studentAccountModel = studentAccountModelFromJson(jsonString);

import 'dart:convert';

StudentAccountModel studentAccountModelFromJson(String str) => StudentAccountModel.fromJson(json.decode(str));

String studentAccountModelToJson(StudentAccountModel data) => json.encode(data.toJson());

class StudentAccountModel {
    StudentAccountModel({
        this.bilhete,
        this.email,
        this.telephone,
        this.process,
        this.classroomId,
    });

    String? bilhete;
    String? email;
    String? telephone;
    int? process;
    String? classroomId;

    factory StudentAccountModel.fromJson(Map<String, dynamic> json) => StudentAccountModel(
        bilhete: json["bilhete"],
        email: json["email"],
        telephone: json["telephone_educator"],
        process: json["process"],
        classroomId: json["classroomId"],
    );

    Map<String, dynamic> toJson() => {
        "bilhete": bilhete,
        "email": email,
        "telephone": telephone,
        "process": process,
        "classroomId": classroomId,
    };
}
