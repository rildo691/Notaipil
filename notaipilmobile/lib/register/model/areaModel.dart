// To parse this JSON data, do
//
//     final area = areaFromJson(jsonString);

import 'dart:convert';

Area areaFromJson(String str) => Area.fromJson(json.decode(str));

String areaToJson(Area data) => json.encode(data.toJson());

class Area {
  String? name;

  Area({
    this.name,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
