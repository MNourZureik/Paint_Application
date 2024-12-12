import 'package:dio/dio.dart';

import '../../../app_config/default_settings.dart';
import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class CategoriesService {
  final _apiRepo = BaseRepository();

  Future<dynamic> getCategories() async {
    var url = APIUrls.BASE_URL +APIUrls.getCategories;
    Options options;
    if(DefaultSetting.user.accessToken!=null){
      options=Options(
          headers: {
            "accept":"application/json",
            "content-type":"application/json",
            "Authorization":"Bearer ${DefaultSetting.user.accessToken}"
          },
          contentType: "application/json"
      );
    }else{
      options=Options(
          headers: {
            "accept":"application/json",
            "content-type":"application/json",
          },
          contentType: "application/json"
      );
    }
    var response = await _apiRepo.requestApi(
      method: APIType.GET,
      url: url,
      options: options
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
