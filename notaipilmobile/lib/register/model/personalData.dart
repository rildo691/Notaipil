// To parse this JSON data, do
//
//     final personalDataModel = personalDataModelFromJson(jsonString);

import 'dart:convert';

PersonalDataModel personalDataModelFromJson(String str) => PersonalDataModel.fromJson(json.decode(str));

String personalDataModelToJson(PersonalDataModel data) => json.encode(data.toJson());

class PersonalDataModel {

  String? fullName;
  DateTime? birthdate;
  String? gender;

  PersonalDataModel({
    this.fullName,
    this.birthdate,
    this.gender,
  });

  factory PersonalDataModel.fromJson(Map<String, dynamic> json) => PersonalDataModel(
    fullName: json["fullName"],
    birthdate: DateTime.parse(json["birthdate"]),
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "birthdate": birthdate!.toIso8601String(),
    "gender": gender,
  };
}
