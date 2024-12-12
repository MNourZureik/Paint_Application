// To parse this JSON data, do
//
//     final gifts = giftsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Gifts giftsFromJson(String str) => Gifts.fromJson(json.decode(str));

String giftsToJson(Gifts data) => json.encode(data.toJson());


class Gifts {
  Gifts({
    required this.gifts,
  });

  final List<Gift> gifts;

  factory Gifts.fromJson(Map<String, dynamic> json) => Gifts(
    gifts: List<Gift>.from(json["gifts"].map((x) => Gift.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gifts": List<dynamic>.from(gifts.map((x) => x.toJson())),
  };
}

class Gift {
  Gift({
    required this.id,
    required this.giftNameInxId,
    required this.giftName,
    required this.giftDescription,
    required this.giftImage,
    required this.date,
    required this.claimId,
  });

  final int id;
  final int giftNameInxId;
  final String giftName;
  final String giftDescription;
  final String giftImage;
  final DateTime date;
  final int claimId;

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
    id: json["id"],
    giftNameInxId: json["gift_name_inx_id"],
    giftName: json["gift_name"]??"",
    giftDescription: json["gift_description"]??"",
    giftImage: json["gift_image"]??"",
    date: DateTime.parse(json["date"]),
    claimId: json["claim_id "]??0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gift_name_inx_id": giftNameInxId,
    "gift_name": giftName,
    "gift_description": giftDescription,
    "gift_image": giftImage,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "claim_id ": claimId,
  };
}
