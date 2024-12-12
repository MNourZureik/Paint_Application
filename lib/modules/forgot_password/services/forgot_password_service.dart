import 'dart:convert';

import 'package:dio/dio.dart';
import '/constant.dart';

import '../../../core/net/app_urls.dart';
import '../../../core/net/constants.dart';
import '../../../core/net/http_client.dart';

class ForgotPasswordService {
  final _apiRepo = BaseRepository();

/* testApi() async {
    var response = await _apiRepo.requestApi(
      method: POST,
      url: APIUrls.EXAMPL_API_NAME,
      data: {

      }
    );
    print(response.success);
    print(response.error);
    print(response.status);
    print(response.data);
  }*/
  Future<dynamic> forgotPassword(Map<String, dynamic> passwordChange) async {
    var url = APIUrls.BASE_URL + APIUrls.forgotPassword;
    print(passwordChange['phone']);

    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      data: jsonEncode({
        "phone_number": passwordChange['phone'],
      }),
      options: Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
      }, contentType: "application/json"),
    );
    print(response.data);
    return response;
  }

  Future<dynamic> verifyCode(Map<String, dynamic> passwordChange) async {
    var url = APIUrls.BASE_URL + APIUrls.verifyCode;
    print('gphone : : $gPhone');
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      data: jsonEncode({
        "phone_number": gPhone.replaceFirst('0', '963'),
        "code": passwordChange['code'],
      }),
      options: Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
      }, contentType: "application/json"),
    );
    print(response.data);
    return response;
  }

  Future<dynamic> restPassword(Map<String, dynamic> passwordChange) async {
    var url = APIUrls.BASE_URL + APIUrls.resetPassword;
      print('gphone: $gPhone');
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      data: jsonEncode({
        "phone_number": gPhone.replaceFirst('0', '963'),
        "code": gCode,
        "password": passwordChange['password'],
        "password_confirmation": passwordChange['password_confirmation'],
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
