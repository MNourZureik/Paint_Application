import 'dart:convert';

import 'package:dio/dio.dart';
import '/core/net/app_urls.dart';
import '/core/net/constants.dart';
import '/core/net/http_client.dart';

class FCMTokenServices {
  final _apiRepo = BaseRepository();

  Future<dynamic> forgotPassword(String fcmToken) async {
    var url = APIUrls.BASE_URL + APIUrls.fcmToken;
    print(fcmToken);

    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      data: jsonEncode({
        "fcm_token": fcmToken,
      }),
      options: Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
      }, contentType: "application/json"),
    );
    print(response.data);
    return response;
  }
}
