// To parse this JSON data, do
//
//     final classRoomModel = classRoomModelFromJson(jsonString);

import 'dart:convert';

ClassroomModel classRoomModelFromJson(String str) => ClassroomModel.fromJson(json.decode(str));

String classRoomModelToJson(ClassroomModel data) => json.encode(data.toJson());

class ClassroomModel {
  String? classroom;
  String? room;

  ClassroomModel({
    this.classroom,
    this.room,
  });

    

  factory ClassroomModel.fromJson(Map<String, dynamic> json) => ClassroomModel(
    classroom: json["classroom"],
    room: json["room"],
  );

  Map<String, dynamic> toJson() => {
    "classroom": classroom,
    "room": room,
  };
}
