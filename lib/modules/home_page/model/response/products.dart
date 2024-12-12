// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

Products productsFromJson(String str) => Products.fromJson(json.decode(str));

String productsToJson(Products data) => json.encode(data.toJson());


class Products {
  Products({
    this.product,
  });

  List<Product>? product;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    product: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(product!.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.image,
    this.isNew,
    this.isSuper,
    this.categoryId,
    this.isFavourite
  });

  int? id;
  String? name;
  String? image;
  int? isNew;
  int? isSuper;
  int? categoryId;
  bool? isFavourite;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    isNew: json["is_new"],
    isSuper: json["is_super"],
    categoryId: json["category_id "],
    isFavourite:json['isFavorite'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "is_new": isNew,
    "is_super": isSuper,
    "category_id ": categoryId,
    "isFavorite ": isFavourite,
  };
}
