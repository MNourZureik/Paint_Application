// To parse this JSON data, do
//
//     final bills = billsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Bills? billsFromJson(String str) => Bills.fromJson(json.decode(str));

String billsToJson(Bills? data) => json.encode(data!.toJson());


class Bills {
  Bills({
    required this.bills,
  });

  final List<Bill?>? bills;

  factory Bills.fromJson(Map<String, dynamic> json) => Bills(
    bills: json["bills"] == null ? [] : json["bills"] == null ? [] : List<Bill?>.from(json["bills"]!.map((x) => Bill.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bills": bills == null ? [] : bills == null ? [] : List<dynamic>.from(bills!.map((x) => x!.toJson())),
  };
}

class Bill {
  Bill({
    required this.id,
    required this.distributorId,
    required this.distributorName,
    required this.memberId,
    required this.billImage,
    required this.uploadDate,
    required this.billCode,
  });

  final int? id;
  final dynamic distributorId;
  final String? distributorName;
  final int? memberId;
  final String? billImage;
  final DateTime? uploadDate;
  final dynamic billCode;

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
    id: json["id"],
    distributorId: json["distributor_id"],
    distributorName: json["distributor_name"],
    memberId: json["member_id"],
    billImage: json["bill_image"],
    uploadDate: DateTime.parse(json ["upload_date"]),
    billCode: json["bill_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "distributor_id": distributorId,
    "distributor_name": distributorName,
    "member_id": memberId,
    "bill_image": billImage,
    "upload_date": uploadDate!.toIso8601String(),
    "bill_code": billCode,
  };
}
