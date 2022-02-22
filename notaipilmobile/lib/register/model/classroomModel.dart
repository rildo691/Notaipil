// To parse this JSON data, do
//
//     final classroomModel = classroomModelFromJson(jsonString);

import 'dart:convert';

ClassroomModel classroomModelFromJson(String str) => ClassroomModel.fromJson(json.decode(str));

String classroomModelToJson(ClassroomModel data) => json.encode(data.toJson());

class ClassroomModel {
    ClassroomModel({
        this.id,
        this.room,
        this.code,
        this.period,
        this.place,
        this.gradeId,
        this.courseId,
    });

    String? id;
    String? room;
    String? code;
    String? period;
    String? place;
    String? gradeId;
    String? courseId;

    factory ClassroomModel.fromJson(Map<String, dynamic> json) => ClassroomModel(
        id: json["id"],
        room: json["room"],
        code: json["code"],
        period: json["period"],
        place: json["place"],
        gradeId: json["gradeId"],
        courseId: json["courseId"],
    );

    Map<String, dynamic> toJson() => {
        "room": room,
        "code": code,
        "period": period,
        "place": place,
        "gradeId": gradeId,
        "courseId": courseId,
    };
}
