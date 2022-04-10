

import 'dart:convert';

Educator educatorFromJson(String str) => Educator.fromJson(json.decode(str));

String educatorToJson(Educator data) => json.encode(data.toJson());

class Educator {
    Educator({
        this.bi,
        this.fullName,
        this.gender,
        this.birthdate,
        this.email,
        this.telephone,
        this.studentId,
        this.studentBi,
    });

    String? bi;
    String? fullName;
    String? gender;
    DateTime? birthdate;
    String? email;
    String? telephone;
    int? studentId;
    String? studentBi;

    factory Educator.fromJson(Map<String, dynamic> json) => Educator(
        bi: json["bi"],
        fullName: json["fullName"],
        gender: json["gender"],
        birthdate: DateTime.parse(json["birthdate"]),
        email: json["email"],
        telephone: json["telephone"],
        studentId: json["studentId"],
        studentBi: json["studentBI"],
    );

    Map<String, dynamic> toJson() => {
        "bi": bi,
        "fullName": fullName,
        "gender": gender,
        "birthdate": "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "email": email,
        "telephone": telephone,
        "studentId": studentId,
        "studentBI": studentBi,
    };
}
