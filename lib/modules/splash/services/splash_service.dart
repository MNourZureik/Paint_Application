import 'package:dio/dio.dart';

import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class SplashService {
  final _apiRepo = BaseRepository();

  Future<dynamic> checkAuth(String token) async {
    var url = APIUrls.BASE_URL + APIUrls.checkAuth;
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      options: Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": token
      }, contentType: "application/json"),
    );
    print(response.data);
    return response;
  }

  Future<dynamic> checkVersion(String version) async {
    var url = APIUrls.BASE_URL + APIUrls.appVersion ;
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      options: Options(
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
        },
        contentType: "application/json",
      ),
      data: {
        "version": version,
      },
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
