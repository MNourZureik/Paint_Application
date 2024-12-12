import 'package:dio/dio.dart';

import '../../../app_config/default_settings.dart';
import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class AdministrationMessagesService {
  final _apiRepo = BaseRepository();

  Future<dynamic> getMessages() async {
    var url = APIUrls.BASE_URL +APIUrls.getMessages;
    var options;
    options=DefaultSetting.user.accessToken==null?Options(
        headers: {
          "accept":"application/json",
          "content-type":"application/json",
        },
        contentType: "application/json"
    ):Options(
        headers: {
          "accept":"application/json",
          "content-type":"application/json",
          "Authorization":"Bearer ${DefaultSetting.user.accessToken}"
        },
        contentType: "application/json"
    );
    var response = await _apiRepo.requestApi(
      method: APIType.GET,
      url: url,
      options: Options(
          headers: {
            "accept":"application/json",
            "content-type":"application/json",
            "Authorization":"Bearer ${DefaultSetting.user.accessToken}"
          },
          contentType: "application/json"
      ),
    );
    print(response.data);
    return response;
  }
  Future<dynamic> getUserMessages() async {
    var url = APIUrls.BASE_URL +APIUrls.getUserMessages;
    var response = await _apiRepo.requestApi(
      method: APIType.GET,
      url: url,
      options: Options(
          headers: {
            "accept":"application/json",
            "content-type":"application/json",
            "Authorization":"Bearer ${DefaultSetting.user.accessToken}"
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
