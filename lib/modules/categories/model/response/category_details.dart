// To parse this JSON data, do
//
//     final categoryDetails = categoryDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import '../../../product_details/model/response/product_details_model.dart';

CategoryDetails categoryDetailsFromJson(String str) => CategoryDetails.fromJson(json.decode(str));

String categoryDetailsToJson(CategoryDetails data) => json.encode(data.toJson());


class CategoryDetails {
  CategoryDetails({
    required this.products,
  });

  final List<Product> products;

  factory CategoryDetails.fromJson(Map<String, dynamic> json) => CategoryDetails(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
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
  final List<Product> relatedProducts;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    image: json['image']=="#"?[]:List<String>.from(json["image"].map((x) => x)),
    categoryId: json["category_id"],
    brochure: json["brochure"]==""?[]:List<Brochure>.from(json["brochure"].map((x) => Brochure.fromJson(x))),
    isNew: json["is_new"],
    isSuper: json["is_super"],
    isFavorite: json["isFavorite"]==null?false:json["isFavorite"],
    description: json["description"],
    availableSizesAndPrices: json["available_sizes_and_prices"]==null?[]:List<AvailableSizesAndPrice>.from(json["available_sizes_and_prices"].map((x) => AvailableSizesAndPrice.fromJson(x))),
    relatedProducts: json['related_products']==null?[]:List<Product>.from(json["related_products"].map((x) => Product.fromJson(x))),
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

