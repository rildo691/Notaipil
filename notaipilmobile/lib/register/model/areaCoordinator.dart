import 'dart:convert';

AreaCoordinator academicYearFromJson(String str) => AreaCoordinator.fromJson(json.decode(str));

String academicYearToJson(AreaCoordinator data) => json.encode(data.toJson());

class AreaCoordinator {

  String? areaId;
  String? teacherAccount;

  AreaCoordinator({
    this.areaId,
    this.teacherAccount,
  });

  factory AreaCoordinator.fromJson(Map<String, dynamic> json) => AreaCoordinator(
    areaId: json["name"],
    teacherAccount: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "name": areaId,
    "isActive": teacherAccount,
  };
}