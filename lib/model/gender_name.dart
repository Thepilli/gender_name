// To parse this JSON data, do
//
//     final genderName = genderNameFromJson(jsonString);

import 'dart:convert';

class GenderName {
  int count;
  String name;
  String gender;
  double probability;

  GenderName({
    required this.count,
    required this.name,
    required this.gender,
    required this.probability,
  });

  factory GenderName.fromRawJson(String str) => GenderName.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenderName.fromJson(Map<String, dynamic> json) => GenderName(
        count: json["count"],
        name: json["name"],
        gender: json["gender"],
        probability: json["probability"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "name": name,
        "gender": gender,
        "probability": probability,
      };
}
