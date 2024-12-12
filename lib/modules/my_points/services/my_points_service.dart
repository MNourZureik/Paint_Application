import 'package:dio/dio.dart';

import '../../../app_config/default_settings.dart';
import '../../../core/net/app_urls.dart';
import '../../../core/net/constants.dart';
import '../../../core/net/http_client.dart';

class MyPointsService {
  final _apiRepo = BaseRepository();

  Future<dynamic> getPoints() async {
    var url = APIUrls.BASE_URL + APIUrls.getPoints;
    var response = await _apiRepo.requestApi(
      method: APIType.GET,
      url: url,
      options: Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer ${DefaultSetting.user.accessToken}"
      }, contentType: "application/json"),
    );
    print(response.data);
    return response;
  }

  Future<dynamic> sendRequest(claimData) async {
    var url = APIUrls.BASE_URL + APIUrls.claim;
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      data: claimData,
      // data: claimData.parse(),
      options: Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer ${DefaultSetting.user.accessToken}"
      }, contentType: "application/json"),
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
