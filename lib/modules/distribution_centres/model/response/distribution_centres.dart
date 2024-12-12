// To parse this JSON data, do
//
//     final distributors = distributorsFromJson(jsonString);

import 'dart:convert';

Distributors distributorsFromJson(String str) => Distributors.fromJson(json.decode(str));

String distributorsToJson(Distributors data) => json.encode(data.toJson());


class Distributors {
  Distributors({
    this.distributors,
  });

  List<Distributor>? distributors;

  factory Distributors.fromJson(Map<String, dynamic> json) => Distributors(
    distributors: List<Distributor>.from(json["distributors"].map((x) => Distributor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "distributors": List<dynamic>.from(distributors!.map((x) => x.toJson())),
  };
}

class Distributor {
  Distributor({
    this.id,
    this.firstName,
    this.lastName,
    this.shopName,
    this.cityId,
    this.cityName,
    this.address,
    this.phone,
    this.isActive,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? shopName;
  int? cityId;
  String? cityName;
  String? address;
  String? phone;
  int? isActive;

  factory Distributor.fromJson(Map<String, dynamic> json) => Distributor(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    shopName: json["shop_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    address: json["address"],
    phone: json["phone"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "shop_name": shopName,
    "city_id": cityId,
    "city_name": cityName,
    "address": address,
    "phone": phone,
    "isActive": isActive,
  };
}
