// To parse this JSON data, do
//
//     final favorites = favoritesFromJson(jsonString);

import 'dart:convert';

import '../../../home_page/model/response/products.dart';

Favorites favoritesFromJson(String str) => Favorites.fromJson(json.decode(str));

String favoritesToJson(Favorites data) => json.encode(data.toJson());



class Favorites {
  Favorites({
    this.products,
  });

  List<Product>? products;

  factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

