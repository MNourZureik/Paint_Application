// To parse this JSON data, do
//
//     final points = pointsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Points? pointsFromJson(String str) => Points.fromJson(json.decode(str));

String pointsToJson(Points? data) => json.encode(data!.toJson());


class Points {
  Points({
    required this.allPoints,
    required this.maxPoints,
    required this.allGifts,
  });

  final int? allPoints;
  final String? maxPoints;
  final List<Gift> allGifts;

  factory Points.fromJson(Map<String, dynamic> json) => Points(
    allPoints: json['all_points'],
    maxPoints: '11',
    allGifts:  List<Gift>.from(json["all_gifts"]!.map((x) => Gift.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "all_points": allPoints,
    "max_points": maxPoints,
    "all_gifts": allGifts == null ? [] : allGifts == null ? [] : List<dynamic>.from(allGifts.map((x) => x.toJson())),
  };
}

class Gift {
  Gift({
    required this.id,
    required this.points,
    required this.image,
  });

  final int? id;
  final String? points;
  final String? image;

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
    id: json["id"],
    points: json["points"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "points": points,
    "image": image,
  };
}
