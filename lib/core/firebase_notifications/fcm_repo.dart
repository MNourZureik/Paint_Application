import 'dart:convert';
import 'dart:developer';

import 'fcm_api.dart';

class FCMTokenRepo {
  var fcmTokenApis = FCMTokenApis();
  Future<void> postFCMToken(String fcmToken) async {
    try {
      print('start repo ==================================');
      var response = await fcmTokenApis.postFCMToken(fcmToken);
      print('fcm res ::: ::: ${response.body}');
      // var responseBody = json.decode(response.body);
    } catch (error) {
      log("error with FCM token");
      //rethrow;
    }
  }
}
