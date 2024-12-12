import 'package:get/get.dart';

class Validators {



  static String validatePhoneNumber(String? value) {
    RegExp phoneRegExp =  RegExp(r'[0-9]{10}$');
    if (value == null || value.isEmpty) {
      return 'phone_number_empty'.tr;
    } else {
      if (value.length < 10) return 'phone_number_length_error'.tr;
      if (value.length > 10) return 'phone_number_length_error'.tr;
      if(!phoneRegExp.hasMatch(value)) return 'phone_number_regex_error'.tr;
      return '';
    }
  }

  static String validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password_empty'.tr;
    } else {
      if (value.length < 8) return 'password_length_error'.tr;
      return '';
    }
  }

  static String validateConfirmPassword(String? value , String password) {
    if (value == null || value.isEmpty) {
      return 'password_confirm_empty'.tr;
    } else {
      if (value.length < 8) return 'password_confirm_length_error'.tr;
      if(value != password) return 'password_and_confirm_mismatch'.tr;
      return '';
    }
  }

  static String validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'name_empty'.tr;
    } else {
      if (value.length < 3) return 'name_length_error'.tr;
      return '';
    }
  }

  static String validatePinCode(String? value) {
    RegExp pinCodeRegExp =  RegExp(r'[0-9]{5}');
    if (value == null || value.isEmpty) {
      return 'pin_code_empty'.tr;
    } else {
      if (value.length < 5) return 'pin_code_length_error'.tr;
      if(!pinCodeRegExp.hasMatch(value)) return 'pin_code_regex_error'.tr;
      return '';
    }
  }

  static String validateAddressTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'address_title_empty'.tr;
    }
    else {
      return '';
    }
  }

  static String validateAddressStreet(String? value) {
    if (value == null || value.isEmpty) {
      return 'address_street_empty'.tr;
    }
    else {
      return '';
    }
  }

  static String validateComplaintTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'complaint_title_empty'.tr;
    }
    else {
      return '';
    }
  }

  static String validateComplaintDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'complaint_description_empty'.tr;
    }
    else {
      return '';
    }
  }

}
