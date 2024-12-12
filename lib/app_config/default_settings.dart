import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../lang/localization_service.dart';
import '../modules/sign_in/model/response/user_model.dart';

class DefaultSetting {
  // Default locale
  static var locale = const Locale('ar', 'SY');
  static var lang = 'ar';
  static TextDirection appDirection = TextDirection.rtl;
  static var isNotificationEnabled = true.obs;
  static late User user;
  static String userType = '';

  static get isArabic => lang == 'ar' ? true : false;
}
