import 'dart:ui';

import 'package:get/get.dart';

import '../lang/ar_sy.dart';
import '../lang/en_us.dart';

class LocalizationService extends Translations {
  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'en',
    'ar',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('en', 'US'),
    const Locale('ar', 'SY'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS,
        'ar_SY': arAR,
      };

  // Gets locale from language, and updates the locale
  static void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  static Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) {
        print(lang);
        print('aaa');
        return locales[i];
      }
    }
    return Get.locale;
  }
}
