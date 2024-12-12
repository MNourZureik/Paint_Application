// To parse this JSON data, do
//
//     final signUp = signUpFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));

String signUpToJson(SignUp data) => json.encode(data.toJson());



class SignUp {
  SignUp({
    required this.id,
    required this.fstName,
    required this.lstName,
    required this.image,
    required this.phoneNumber,
    required this.isActive,
    required this.accessToken,
  });

  final int id;
  final String fstName;
  final String lstName;
  final String image;
  final String phoneNumber;
  final int isActive;
  final String accessToken;

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
    id: json["id"],
    fstName: json["fstName"],
    lstName: json["lstName"],
    image: json["image"],
    phoneNumber: json["phone_number"],
    isActive: json["isActive"],
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fstName": fstName,
    "lstName": lstName,
    "image": image,
    "phone_number": phoneNumber,
    "isActive": isActive,
    "access_token": accessToken,
  };
}
