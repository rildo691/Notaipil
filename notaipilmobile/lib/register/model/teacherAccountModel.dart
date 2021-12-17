// To parse this JSON data, do
//
//     final teacherAccountModel = teacherAccountModelFromJson(jsonString);

import 'dart:convert';

TeacherAccountModel teacherAccountModelFromJson(String str) => TeacherAccountModel.fromJson(json.decode(str));

String teacherAccountModelToJson(TeacherAccountModel data) => json.encode(data.toJson());

class TeacherAccountModel {
    TeacherAccountModel({
        this.bi,
        this.fullName,
        this.birthdate,
        this.gender,
        this.email,
        this.telephone,
        this.qualificationId,
        this.regime,
        this.ipilDate,
        this.educationDate,
        this.category,
    });

    String? bi;
    String? fullName;
    String? birthdate;
    String? gender;
    String? email;
    String? telephone;
    String? qualificationId;
    String? regime;
    DateTime? ipilDate;
    DateTime? educationDate;
    String? category;

    factory TeacherAccountModel.fromJson(Map<String, dynamic> json) => TeacherAccountModel(
        bi: json["bi"],
        fullName: json["fullName"],
        birthdate: json["birthdate"],
        gender: json["gender"],
        email: json["email"],
        telephone: json["telephone"],
        qualification: json["qualificationId"],
        regime: json["regime"],
        ipilDate: DateTime.parse(json["ipilDate"]),
        educationDate: DateTime.parse(json["educationDate"]),
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "bi": bi,
        "fullName": fullName,
        "birthdate": birthdate,
        "gender": gender,
        "email": email,
        "telephone": telephone,
        "qualificationId": qualification,
        "regime": regime,
        "ipilDate": "${ipilDate!.year.toString().padLeft(4, '0')}-${ipilDate!.month.toString().padLeft(2, '0')}-${ipilDate!.day.toString().padLeft(2, '0')}",
        "educationDate": "${educationDate!.year.toString().padLeft(4, '0')}-${educationDate!.month.toString().padLeft(2, '0')}-${educationDate!.day.toString().padLeft(2, '0')}",
        "category": category,

    };
}
