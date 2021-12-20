// To parse this JSON data, do
//
//     final qualificationsModel = qualificationsModelFromJson(jsonString);

import 'dart:convert';

QualificationsModel qualificationsModelFromJson(String str) => QualificationsModel.fromJson(json.decode(str));

String qualificationsModelToJson(QualificationsModel data) => json.encode(data.toJson());

class QualificationsModel {
    QualificationsModel({
        this.id,
        this.name,
    });

    String? id;
    String? name;

    factory QualificationsModel.fromJson(Map<String, dynamic> json) => QualificationsModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
