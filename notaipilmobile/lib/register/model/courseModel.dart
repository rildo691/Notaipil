// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
    CourseModel({
        this.name,
        this.code,
        this.area,
    });

    String? name;
    String? code;
    Area? area;

    factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        name: json["name"],
        code: json["code"],
        area: Area.fromJson(json["area"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "area": area!.toJson(),
    };
}

class Area {
    Area({
        this.id,
    });

    String? id;

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
    };
}
