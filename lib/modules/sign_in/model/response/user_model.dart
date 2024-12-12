// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import '../../../../core/secure_storage.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.fstName,
    this.lstName,
    this.image,
    this.phoneNumber,
    this.isActive,
    this.accessToken,
    this.userableId,
    this.userableType,
    this.classification,
    this.work,
    this.shopName,
    this.address,
  });

  int? id;
  String? fstName;
  String? lstName;
  String? image;
  String? phoneNumber;
  int? isActive;
  String? accessToken;
  int? userableId;
  String? userableType;
  String? classification;
  String? work;
  String? shopName;
  String? address;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fstName: json["fstName"],
    lstName: json["lstName"],
    image: json["image"],
    phoneNumber: json["phone_number"],
    isActive: json["isActive"],
    accessToken: json["access_token"],
    userableId: json["Userable_id"],
    userableType: json["Userable_type"],
    classification: json["classification"],
    work: json["work"],
    shopName: json["shop_name"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fstName": fstName,
    "lstName": lstName,
    "image": image,
    "phone_number": phoneNumber,
    "isActive": isActive,
    "access_token": accessToken,
    "Userable_id": userableId,
    "Userable_type": userableType,
    "classification": classification,
    "work": work,
    "shop_name": shopName,
    "address": address,
  };
  static late SecureStorage secureStorage;

  saveData() async {
    secureStorage = SecureStorage();
    secureStorage.storeValue('user_firstname', fstName);
    secureStorage.storeValue('user_lastname', lstName);
    secureStorage.storeValue('image', image);
    secureStorage.storeValue('phone_number', phoneNumber);
    secureStorage.storeValue('isActive', isActive.toString());
    secureStorage.storeValue('access_token', accessToken);
    secureStorage.storeValue('Userable_id', userableId.toString());
    secureStorage.storeValue('Userable_type', userableType);
    secureStorage.storeValue('classification', classification);
    secureStorage.storeValue('work', work);
    secureStorage.storeValue('shop_name', shopName);
    secureStorage.storeValue('address', address);
    secureStorage.storeValue('id', id.toString());
    secureStorage.storeValue('signed in','true');
  }

  updateData() {
    secureStorage = SecureStorage();
    secureStorage.storeValue('user_firstname', fstName);
    secureStorage.storeValue('user_lastname', lstName);
    secureStorage.storeValue('image', image);
    secureStorage.storeValue('phone_number', phoneNumber);
    secureStorage.storeValue('isActive', isActive.toString());
    secureStorage.storeValue('access_token', accessToken);
    secureStorage.storeValue('Userable_id', userableId.toString());
    secureStorage.storeValue('Userable_type', userableType);
    secureStorage.storeValue('classification', classification);
    secureStorage.storeValue('work', work);
    secureStorage.storeValue('shop_name', shopName);
    secureStorage.storeValue('address', address);
    secureStorage.storeValue('id', id.toString());
  }
  Future<User> readData() async{
    secureStorage = SecureStorage();
    User user;
    String? accessToken=await secureStorage.readValue('access_token');
    String? firstName=await secureStorage.readValue('user_firstname') ;
    String? lastName=await secureStorage.readValue('user_lastname');
    String? image=await secureStorage.readValue('image');
    String? phoneNumber=await secureStorage.readValue('phone_number');
    String? isActive=await secureStorage.readValue('isActive');
    int? issActive;
    if(isActive!=null){
      issActive=int.parse(isActive!);
    }
    String? userableId=await secureStorage.readValue('Userable_id');
    int? userableIdd;
    if(userableId!=null){
      userableIdd=int.parse(userableId!);
    }
    String? userableType=await secureStorage.readValue('Userable_type');
    String? classification=await secureStorage.readValue('classification');
    String? work=await secureStorage.readValue('work');
    String? address=await secureStorage.readValue('address') ;
    String? shopName=await secureStorage.readValue('shop_name') ;
    String? id=await secureStorage.readValue('id') ;
    int? idd;
    if(id!=null){
      idd=int.parse(id!);
    }
    user=User(
      accessToken: accessToken,
      phoneNumber: phoneNumber,
      address: address,
      classification: classification,
      fstName: firstName,
      lstName: lastName,
      image: image,
      isActive: issActive,
      shopName: shopName,
      userableId: userableIdd,
      userableType: userableType,
      work: work,
      id: idd
    );

    return user;
  }
  Future<String> readToken() async {
    secureStorage = SecureStorage();
    String? token = await secureStorage.readValue('access_token');
    return token!;
  }
  clearToken() async {
    secureStorage.deleteValue('access_token');
    secureStorage.storeValue('signed in','false');

  }
  clearData() async {
    secureStorage.deleteValue('access_token');
    secureStorage.deleteValue('user_firstname');
    secureStorage.deleteValue('user_lastname');
    secureStorage.deleteValue('image');
    secureStorage.deleteValue('phone_number');
    secureStorage.deleteValue('isActive');
    secureStorage.deleteValue('Userable_id');
    secureStorage.deleteValue('Userable_type');
    secureStorage.deleteValue('classification');
    secureStorage.deleteValue('work');
    secureStorage.deleteValue('address');
    secureStorage.deleteValue('shop_name');
    secureStorage.deleteValue('id');
  }
}
