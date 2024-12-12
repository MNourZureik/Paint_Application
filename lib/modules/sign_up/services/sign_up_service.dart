import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../app_config/default_settings.dart';
import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';
import '../model/request/sign_up_data.dart';

class SignUpService {
  final _apiRepo = BaseRepository();

  Future<dynamic> getCities() async {
    var url = APIUrls.BASE_URL +APIUrls.getCities;
    var response = await _apiRepo.requestApi(
      method: APIType.GET,
      url: url,
      options: Options(
          headers: {
            "accept":"application/json",
            "content-type":"application/json",
          },
          contentType: "application/json"
      ),
    );
    print(response.data);
    return response;
  }

  Future<dynamic> signUp(SignUpData signInData) async {
    var url = APIUrls.BASE_URL +APIUrls.signUp ;
    print(url);
    print(signInData.phoneNumber);
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      data: jsonEncode({
        "phone_number":signInData.phoneNumber,
        "password":signInData.password,
        "password_confirmation":signInData.passwordConfirmation,
        "fstName":signInData.fstName,
        "lstName":signInData.lstName,
        "work":signInData.work,
        "city_id":signInData.cityId,
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
