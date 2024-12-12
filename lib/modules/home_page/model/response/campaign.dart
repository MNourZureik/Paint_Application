// To parse this JSON data, do
//
//     final campaign = campaignFromJson(jsonString);

import 'dart:convert';

Campaign campaignFromJson(String str) => Campaign.fromJson(json.decode(str));

String campaignToJson(Campaign data) => json.encode(data.toJson());

class Campaign {
  Campaign({
    this.id,
    this.startDate,
    this.endDate,
    this.gainStartDate,
    this.gainEndDate,
    this.description,
    this.giftsNames,
    this.distributors,
    this.usersNumber,
    this.givenPointsNumber,
    this.products,
    this.file,
  });

  int? id;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? gainStartDate;
  DateTime? gainEndDate;
  String? description;
  List<GiftsName>? giftsNames;
  List<Distributor>? distributors;
  int? usersNumber;
  int? givenPointsNumber;
  List<dynamic>? products;
  String? file;

  factory Campaign.fromJson(Map<String, dynamic> json) => Campaign(
        id: json["id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        gainStartDate: DateTime.parse(json["gain_start_date"]),
        gainEndDate: DateTime.parse(json["gain_end_date"]),
        description: json["description"],
        giftsNames: List<GiftsName>.from(
            json["giftsNames"].map((x) => GiftsName.fromJson(x))),
        distributors: List<Distributor>.from(
            json["distributors"].map((x) => Distributor.fromJson(x))),
        usersNumber: json["users_number"],
        givenPointsNumber: json["given_points_number"],
        products: List<dynamic>.from(json["products"].map((x) => x)),
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "gain_start_date":
            "${gainStartDate!.year.toString().padLeft(4, '0')}-${gainStartDate!.month.toString().padLeft(2, '0')}-${gainStartDate!.day.toString().padLeft(2, '0')}",
        "gain_end_date":
            "${gainEndDate!.year.toString().padLeft(4, '0')}-${gainEndDate!.month.toString().padLeft(2, '0')}-${gainEndDate!.day.toString().padLeft(2, '0')}",
        "description": description,
        "giftsNames": List<dynamic>.from(giftsNames!.map((x) => x.toJson())),
        "distributors":
            List<dynamic>.from(distributors!.map((x) => x.toJson())),
        "users_number": usersNumber,
        "given_points_number": givenPointsNumber,
        "products": List<dynamic>.from(products!.map((x) => x)),
        "file" : file,
      };
}

class Distributor {
  Distributor({
    this.id,
  });

  String? id;

  factory Distributor.fromJson(Map<String, dynamic> json) => Distributor(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class GiftsName {
  GiftsName({
    this.id,
    this.points,
  });

  String? id;
  String? points;

  factory GiftsName.fromJson(Map<String, dynamic> json) => GiftsName(
        id: json["id"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "points": points,
      };
}
