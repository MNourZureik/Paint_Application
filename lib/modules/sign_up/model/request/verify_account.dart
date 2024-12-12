import 'dart:convert';

class VerifyCode {
  final String phoneNumber;
  final String code;


  VerifyCode(
      {required this.phoneNumber,
        required this.code});

  Map<String, dynamic> toJson() => {
    "phone": phoneNumber,
    "code":code
  };

  String parse() {
    return jsonEncode(toJson());
  }
}
