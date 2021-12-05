// To parse this JSON data, do
//
//     final classRoomScheduleModel = classRoomScheduleModelFromJson(jsonString);

import 'dart:convert';

ClassroomScheduleModel classRoomScheduleModelFromJson(String str) => ClassroomScheduleModel.fromJson(json.decode(str));

String classRoomScheduleModelToJson(ClassroomScheduleModel data) => json.encode(data.toJson());

class ClassroomScheduleModel {

  String? name;

  ClassroomScheduleModel({
    this.name,
  });

  factory ClassroomScheduleModel.fromJson(Map<String, dynamic> json) => ClassroomScheduleModel(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
