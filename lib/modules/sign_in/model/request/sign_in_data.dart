import 'dart:convert';

class SignInData{
  late String phoneNumber;
  late String password;

  SignInData({
    this.phoneNumber='',
    this.password='',
});

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "password": password,
  };

  String parse(){
    return jsonEncode(toJson());
  }
}