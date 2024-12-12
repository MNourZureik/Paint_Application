// To parse this JSON data, do
//
//     final distToSend = distToSendFromJson(jsonString);

import 'dart:convert';

DistToSend distToSendFromJson(String str) => DistToSend.fromJson(json.decode(str));

String distToSendToJson(DistToSend data) => json.encode(data.toJson());


class DistToSend {
  DistToSend({
    required this.distributors,
  });

  List<DistributorToSend> distributors;

  factory DistToSend.fromJson(Map<String, dynamic> json) => DistToSend(
    distributors: List<DistributorToSend>.from(json["distributors"].map((x) => DistributorToSend.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "distributors": List<dynamic>.from(distributors.map((x) => x.toJson())),
  };
}

class DistributorToSend {
  DistributorToSend({
    required this.id,
    required this.name,
    required this.address,
  });

  int id;
  String name;
  String address;

  factory DistributorToSend.fromJson(Map<String, dynamic> json) => DistributorToSend(
    id: json["id"],
    name: json["name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
  };
}
