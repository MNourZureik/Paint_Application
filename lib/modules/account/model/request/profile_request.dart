import 'dart:convert';

class ProfileRequest{
  final String firstName;
  final String lastName;
  final int cityId;
  final String work;

  ProfileRequest({
    required this.lastName,
    required this.firstName,
    required this.cityId,
    required this.work
});

  Map<String, dynamic> toJson() => {
    "fstName": firstName,
    "lstName": lastName,
    "work": work,
    "city_id": cityId,
  };

  String parse(){
    return jsonEncode(toJson());
  }
}