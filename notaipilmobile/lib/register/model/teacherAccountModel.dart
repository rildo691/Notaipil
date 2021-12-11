// To parse this JSON data, do
//
//     final teacherAccountModel = teacherAccountModelFromJson(jsonString);

import 'dart:convert';

TeacherAccountModel teacherAccountModelFromJson(String str) => TeacherAccountModel.fromJson(json.decode(str));

String teacherAccountModelToJson(TeacherAccountModel data) => json.encode(data.toJson());

class TeacherAccountModel {
    TeacherAccountModel({
        this.email,
        this.telephone,
        this.qualification,
        this.regime,
        this.ipilDate,
        this.educationDate,
        this.category,
        this.statusForm,
        this.personalDataId,
        this.typeAccountId,
    });

    String? email;
    String? telephone;
    String? qualification;
    String? regime;
    DateTime? ipilDate;
    DateTime? educationDate;
    String? category;
    String? statusForm;
    String? personalDataId;
    String? typeAccountId;

    factory TeacherAccountModel.fromJson(Map<String, dynamic> json) => TeacherAccountModel(
        email: json["email"],
        telephone: json["telephone"],
        qualification: json["qualification"],
        regime: json["regime"],
        ipilDate: DateTime.parse(json["ipilDate"]),
        educationDate: DateTime.parse(json["educationDate"]),
        category: json["category"],
        statusForm: json["statusForm"],
        personalDataId: json["personalDataId"],
        typeAccountId: json["typeAccountId"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "telephone": telephone,
        "qualification": qualification,
        "regime": regime,
        "ipilDate": "${ipilDate!.year.toString().padLeft(4, '0')}-${ipilDate!.month.toString().padLeft(2, '0')}-${ipilDate!.day.toString().padLeft(2, '0')}",
        "educationDate": "${educationDate!.year.toString().padLeft(4, '0')}-${educationDate!.month.toString().padLeft(2, '0')}-${educationDate!.day.toString().padLeft(2, '0')}",
        "category": category,
        "statusForm": statusForm,
        "personalDataId": personalDataId,
        "typeAccountId": typeAccountId,
    };
}
