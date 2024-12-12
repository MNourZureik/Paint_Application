// To parse this JSON data, do
//
//     final distBills = distBillsFromJson(jsonString);

import 'dart:convert';

DistBills distBillsFromJson(String str) => DistBills.fromJson(json.decode(str));

String distBillsToJson(DistBills data) => json.encode(data.toJson());


class DistBills {
  DistBills({
    required this.bills,
  });

  List<DistBill> bills;

  factory DistBills.fromJson(Map<String, dynamic> json) => DistBills(
    bills: List<DistBill>.from(json["bills"].map((x) => DistBill.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "bills": List<dynamic>.from(bills.map((x) => x.toJson())),
  };
}

class DistBill {
  DistBill({
    required this.id,
    required this.memberWork,
    required this.memberName,
    required this.memberId,
    required this.billImage,
    required this.uploadDate,
    required this.billCode,
  });

  int id;
  String memberWork;
  String memberName;
  int memberId;
  String billImage;
  DateTime uploadDate;
  String billCode;

  factory DistBill.fromJson(Map<String, dynamic> json) => DistBill(
    id: json["id"],
    memberWork: json["member_work"],
    memberName: json["member_name"],
    memberId: json["member_id"],
    billImage: json["bill_image"],
    uploadDate: DateTime.parse(json["upload_date"]),
    billCode: json["bill_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "member_work": memberWork,
    "member_name": memberName,
    "member_id": memberId,
    "bill_image": billImage,
    "upload_date": uploadDate.toIso8601String(),
    "bill_code": billCode,
  };
}
