// To parse this JSON data, do
//
//     final subCategory = subCategoryFromJson(jsonString);

import '/modules/product_details/model/response/product_details_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import '../../../home_page/model/response/products.dart';

SubCategory subCategoryFromJson(String str) => SubCategory.fromJson(json.decode(str));

String subCategoryToJson(SubCategory data) => json.encode(data.toJson());


class SubCategory {
  SubCategory({
    required this.categories,
  });

  final List<Category> categories;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
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
    required this.products,
    required this.brochure,
  });

  final int id;
  final String name;
  final String image;
  final String description;
  final int isFinal;
  final List<Brochure> brochure;
  final List<Product> products;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    isFinal: json["is_final"],
    brochure: json["brochure"]==""||json["brochure"]==null?[]:List<Brochure>.from(json["brochure"].map((x) => Brochure.fromJson(x))),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "description": description,
    "is_final": isFinal,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

