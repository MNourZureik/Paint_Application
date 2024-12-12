// To parse this JSON data, do
//
//     final auth = authFromJson(jsonString);

import 'dart:convert';

Auth authFromJson(String str) => Auth.fromJson(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
  Auth({
    this.id,
    this.fstName,
    this.lstName,
    this.image,
    this.phoneNumber,
    this.isActive,
    this.userableType,
    this.code,
  });

  int? id;
  String? fstName;
  String? lstName;
  String? image;
  String? phoneNumber;
  int? isActive;
  String? userableType;
  String? code;

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
      id: json["id"],
      fstName: json["fstName"],
      lstName: json["lstName"],
      image: json["image"],
      phoneNumber: json["phone_number"],
      isActive: json["isActive"],
      userableType: json["Userable_type"],
      code: json["code"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "fstName": fstName,
        "lstName": lstName,
        "image": image,
        "phone_number": phoneNumber,
        "isActive": isActive,
        "Userable_type": userableType,
        "code": code,
      };
}
