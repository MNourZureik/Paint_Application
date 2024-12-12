import 'dart:convert';

import 'package:dio/dio.dart';
import '/modules/sign_up/model/request/verify_account.dart';

import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class VerifyAccountService {
  final _apiRepo = BaseRepository();

  Future<dynamic> verify(VerifyCode code) async {
    var url = APIUrls.BASE_URL +APIUrls.verifyAccount ;
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      data: code.parse(),
      options: Options(
          headers: {
            "accept":"application/json",
            "content-type":"application/json"
          },
          contentType: "application/json"
      ),
    );
    print(response.data);
    return response;
  }
  Future<dynamic> reSendCode(String phoneNumber) async {
    print('new number$phoneNumber');
    var url = APIUrls.BASE_URL +APIUrls.reSendCode ;
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      data: jsonEncode({
        "phone":phoneNumber
      }),
      options: Options(
          headers: {
            "accept":"application/json",
            "content-type":"application/json"
          },
          contentType: "application/json"
      ),
    );
    print(response.data);
    return response;
  }

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
}
