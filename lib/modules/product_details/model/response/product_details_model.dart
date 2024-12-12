// To parse this JSON data, do
//
//     final productDetails = productDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';


ProductDetails productDetailsFromJson(String str) => ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());


class ProductDetails {
  ProductDetails({
    required this.id,
    required this.name,
    required this.image,
    required this.categoryId,
    required this.brochure,
    required this.isNew,
    required this.isSuper,
    required this.isFavorite,
    required this.description,
    required this.availableSizesAndPrices,
    required this.relatedProducts,
  });

  final int id;
  final String name;
  final List<String> image;
  final int categoryId;
  final List<Brochure> brochure;
  final int isNew;
  final int isSuper;
  final dynamic isFavorite;
  final String description;
  final List<AvailableSizesAndPrice> availableSizesAndPrices;
  final List<ProductDetails> relatedProducts;

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    id: json["id"],
    name: json["name"],
    image: List<String>.from(json["image"].map((x) => x)),
    categoryId: json["category_id"],
    brochure: json["brochure"] is String?[]:List<Brochure>.from(json["brochure"].map((x) => Brochure.fromJson(x))),
    isNew: json["is_new"],
    isSuper: json["is_super"],
    isFavorite: json["isFavorite"]==null?false:json["isFavorite"],
    description: json["description"],
    availableSizesAndPrices: json['available_sizes_and_prices']==null?[]:List<AvailableSizesAndPrice>.from(json["available_sizes_and_prices"].map((x) => AvailableSizesAndPrice.fromJson(x))),
    relatedProducts: json['related_products']==null?[]:List<ProductDetails>.from(json["related_products"].map((x) => ProductDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": List<dynamic>.from(image.map((x) => x)),
    "category_id": categoryId,
    "brochure": List<dynamic>.from(brochure.map((x) => x.toJson())),
    "is_new": isNew,
    "is_super": isSuper,
    "isFavorite": isFavorite,
    "description": description,
    "available_sizes_and_prices": List<dynamic>.from(availableSizesAndPrices.map((x) => x.toJson())),
    "related_products": List<dynamic>.from(relatedProducts.map((x) => x.toJson())),
  };
}

class AvailableSizesAndPrice {
  AvailableSizesAndPrice({
    required this.price,
    required this.size,
  });

  final String price;
  final String size;

  factory AvailableSizesAndPrice.fromJson(Map<String, dynamic> json) => AvailableSizesAndPrice(
    price: json["price"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "size": size,
  };
}

class Brochure {
  Brochure({
    required this.link,
    required this.name,
  });

  final String link;
  final String name;

  factory Brochure.fromJson(Map<String, dynamic> json) => Brochure(
    link: json["link"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "name": name,
  };
}
