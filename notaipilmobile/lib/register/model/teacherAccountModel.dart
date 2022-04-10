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
        this.avatar,
    });

    String? bi;
    String? fullName;
    DateTime? birthdate;
    String? gender;
    String? email;
    String? telephone;
    String? qualificationId;
    String? regime;
    DateTime? ipilDate;
    DateTime? educationDate;
    String? category;
    String? avatar;

    factory TeacherAccountModel.fromJson(Map<String, dynamic> json) => TeacherAccountModel(
        bi: json["bi"],
        fullName: json["fullName"],
        birthdate: DateTime.parse(json["birthdate"]),
        gender: json["gender"],
        email: json["email"],
        telephone: json["telephone"],
        qualificationId: json["qualificationId"],
        regime: json["regime"],
        ipilDate: DateTime.parse(json["ipilDate"]),
        educationDate: DateTime.parse(json["educationDate"]),
        category: json["category"],
        avatar: json["avatar"]
    );

    Map<String, dynamic> toJson() => {
        "bi": bi,
        "fullName": fullName,
        "birthdate": "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "email": email,
        "telephone": telephone,
        "qualificationId": qualificationId,
        "regime": regime,
        "ipilDate": "${ipilDate!.year.toString().padLeft(4, '0')}-${ipilDate!.month.toString().padLeft(2, '0')}-${ipilDate!.day.toString().padLeft(2, '0')}",
        "educationDate": "${educationDate!.year.toString().padLeft(4, '0')}-${educationDate!.month.toString().padLeft(2, '0')}-${educationDate!.day.toString().padLeft(2, '0')}",
        "category": category,
        "avatar": avatar,
    };
}
