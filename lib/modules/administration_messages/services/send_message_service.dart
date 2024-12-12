import 'package:dio/dio.dart';
import '/modules/administration_messages/model/request/send_message.dart';

import '../../../app_config/default_settings.dart';
import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class SendMessageService {
  final _apiRepo = BaseRepository();

  Future<dynamic> getDistributors() async {
    var url = APIUrls.BASE_URL + APIUrls.getOnlyDist;
    var options;
    if (DefaultSetting.user.accessToken == null) {
      options = Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
      }, contentType: "application/json");
    } else {
      options = Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer ${DefaultSetting.user.accessToken}"
      }, contentType: "application/json");
    }
    var response = await _apiRepo.requestApi(
        method: APIType.GET, url: url, options: options);
    print(response.data);
    return response;
  }

  Future<dynamic> sendMessage(SendMessageData sendMessageData) async {
    var url = APIUrls.BASE_URL + APIUrls.sendMessageByGuest;

    print(sendMessageData.toString());
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      options: Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
      }, contentType: "application/json"),
      data: sendMessageData.parse(),
    );
    print(response.data);
    return response;
  }

  Future<dynamic> sendMessageByMember(
      SendMessageDataByMember sendMessageData) async {
    var url = APIUrls.BASE_URL + APIUrls.sendMessageByMember;

    print(sendMessageData.toString());
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      options: Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer ${DefaultSetting.user.accessToken}"
      }, contentType: "application/json"),
      data: sendMessageData.parse(),
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
