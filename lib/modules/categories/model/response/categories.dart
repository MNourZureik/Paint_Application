// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import '../../../product_details/model/response/product_details_model.dart';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());


class Categories {
  Categories({
    required this.categories,
  });

  final List<Category> categories;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.isFinal,
    required this.brochure,
  });

  final int id;
  final String name;
  final String image;
  final String description;
  final List<Brochure> brochure;
  final int isFinal;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    isFinal: json["is_final"],
    brochure: json["brochure"]==""?[]:List<Brochure>.from(json["brochure"].map((x) => Brochure.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
    "is_final":isFinal,
  };
}
