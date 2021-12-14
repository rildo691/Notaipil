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
        this.emailEducator,
        this.telephoneEducator,
        this.process,
        this.classroomId,
    });

    String? bilhete;
    String? email;
    String? emailEducator;
    String? telephoneEducator;
    int? process;
    String? classroomId;

    factory StudentAccountModel.fromJson(Map<String, dynamic> json) => StudentAccountModel(
        bilhete: json["bilhete"],
        email: json["email"],
        emailEducator: json["email_educator"],
        telephoneEducator: json["telephone_educator"],
        process: json["process"],
        classroomId: json["classroomId"],
    );

    Map<String, dynamic> toJson() => {
        "bilhete": bilhete,
        "email": email,
        "email_educator": emailEducator,
        "telephone_educator": telephoneEducator,
        "process": process,
        "classroomId": classroomId,
    };
}
