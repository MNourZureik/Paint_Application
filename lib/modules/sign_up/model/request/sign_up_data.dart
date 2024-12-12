  import 'dart:convert';

  class SignUpData {
    final String phoneNumber;
    final String fstName, lstName;
    final String passwordConfirmation;
    final String password;
    final String work;
    final int cityId;

    SignUpData(
        {required this.phoneNumber,
        required this.password,
        required this.passwordConfirmation,
        required this.lstName,
        required this.fstName,
        required this.work,
        required this.cityId,
        });

    Map<String, dynamic> toJson() => {
          "phone_number": phoneNumber,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "city_id": cityId,
          "fstName": fstName,
          "lstName": lstName,
          "work": work,
        };

    String parse() {
      return jsonEncode(toJson());
    }
  }
