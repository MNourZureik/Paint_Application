// To parse this JSON data, do
//
//     final cities = citiesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Cities citiesFromJson(String str) => Cities.fromJson(json.decode(str));

String citiesToJson(Cities data) => json.encode(data.toJson());


class Cities {
  Cities({
    required this.cities,
  });

  final List<City> cities;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
    cities: List<City>.from(json["cities"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
  };
}

class City {
  City({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
  bool isContain(String? text){
    if(text == null) return true;
    if(text.isEmpty) return true;
    if(name.toLowerCase().contains(text.toLowerCase())) return true;

    return false;
  }

}
