import 'dart:convert';

import 'package:dio/dio.dart';
import '/modules/sign_in/model/request/sign_in_data.dart';

import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class SignInService {
  final _apiRepo = BaseRepository();


Future<dynamic> signIn(SignInData signInData) async {
    var url = APIUrls.BASE_URL +APIUrls.signIn ;
    print(url);
    var response = await _apiRepo.requestApi(
        method: APIType.POST,
        url: url,
        data: jsonEncode({
          "phone_number":signInData.phoneNumber,
          "password":signInData.password,
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
  Future<dynamic> checkAuth(String token) async {
    var url = APIUrls.BASE_URL +APIUrls.checkAuth ;
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      options: Options(
          headers: {
            "accept":"application/json",
            "content-type":"application/json",
            "Authorization":"${token}"
          },
          contentType: "application/json"
      ),
    );
    print(response.data);
    return response;
  }





}
