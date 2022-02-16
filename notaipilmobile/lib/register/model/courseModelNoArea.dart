// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModelNoArea courseModelFromJson(String str) => CourseModelNoArea.fromJson(json.decode(str));

String courseModelToJson(CourseModelNoArea data) => json.encode(data.toJson());

class CourseModelNoArea {
    CourseModelNoArea({
        this.id,
        this.name,
        this.code,
    });

    String? id;
    String? name;
    String? code;

    factory CourseModelNoArea.fromJson(Map<String, dynamic> json) => CourseModelNoArea(
        id: json["id"],
        name: json["name"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
    };
}