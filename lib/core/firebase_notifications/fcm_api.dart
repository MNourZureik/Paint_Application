import 'dart:convert';

import 'package:http/http.dart' as http;

import '../net/app_urls.dart';
import '/app_config/default_settings.dart';

class FCMTokenApis {
  Future<http.Response> postFCMToken(String fcmToken) async {
    try {
      Map<String, String> headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${DefaultSetting.user.accessToken}"
      };
      Map<String, dynamic> body = {
        'fcm_token': fcmToken,
      };
      print('start api ==================================$fcmToken');
      Uri url = Uri.parse('${APIUrls.BASE_URL}/api/deviceToken');
      var response =
          await http.post(url, headers: headers, body: json.encode(body));
      print('-----------------------------------------');
      print(response.statusCode);
      print('-----------------------------------------');
      if (response.statusCode != 200) {
        throw Exception('error : ${response.statusCode}');
      }
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
