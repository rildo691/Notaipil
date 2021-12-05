import 'dart:convert';

AcademicYear academicYearFromJson(String str) => AcademicYear.fromJson(json.decode(str));

String academicYearToJson(AcademicYear data) => json.encode(data.toJson());

class AcademicYear {

  String? name;
  bool? isActive;

  AcademicYear({
    this.name,
    this.isActive,
  });

  factory AcademicYear.fromJson(Map<String, dynamic> json) => AcademicYear(
    name: json["name"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "isActive": isActive,
  };
}