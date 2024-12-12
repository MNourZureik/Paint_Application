import 'package:dio/dio.dart';

import '../../../app_config/default_settings.dart';
import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class DistributionCentresService {
  final _apiRepo = BaseRepository();

  Future<dynamic> getDistributors(bool isFilter, int? cityId) async {
    var url = APIUrls.BASE_URL + APIUrls.getDistributors;
    if (isFilter) {
      url =
          '${APIUrls.BASE_URL}${APIUrls.getDistributors}?filters[city_id]=$cityId';
    }
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
