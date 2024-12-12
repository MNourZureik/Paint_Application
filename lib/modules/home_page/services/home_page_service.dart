import 'dart:developer';

import 'package:dio/dio.dart';
import '/app_config/default_settings.dart';

import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class HomePageService {
  final _apiRepo = BaseRepository();
  Options withAuth = Options(headers: {
    "accept": "application/json",
    "content-type": "application/json",
    "Authorization": "${DefaultSetting.user.accessToken}"
  });
  Options noAuth = Options(headers: {
    "accept": "application/json",
    "content-type": "application/json",
  });
  Future<dynamic> getCurrentCampaign() async {
    var url = APIUrls.BASE_URL + APIUrls.currentCampaign;
    var response = await _apiRepo.requestApi(
        method: APIType.GET,
        url: url,
        options: DefaultSetting.userType == 'guest'
            ? noAuth
            : Options(headers: {
                "accept": "application/json",
                "content-type": "application/json",
                "Authorization": "Bearer ${DefaultSetting.user.accessToken}"
              }));
    log("logging for current campign : ${response.data}");
    return response;
  }

  Future<dynamic> getProducts() async {
    print("sakdkasd");
    print(DefaultSetting.userType == 'guest');
    var url = APIUrls.BASE_URL + APIUrls.getProducts;
    var response = await _apiRepo.requestApi(
      method: APIType.GET,
      url: url,
      options: DefaultSetting.userType == 'guest' ? noAuth : withAuth,
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
