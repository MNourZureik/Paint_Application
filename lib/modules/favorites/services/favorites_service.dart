import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../app_config/default_settings.dart';
import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class FavoritesService {
  final _apiRepo = BaseRepository();

  Future<dynamic> getProducts() async {
    var url = APIUrls.BASE_URL +APIUrls.getFavorites;
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
  Future<dynamic> updateFavorite(productId) async {
    var url = APIUrls.BASE_URL +APIUrls.updateFavorite;
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      options: Options(
          headers: {
            "accept":"application/json",
            "content-type":"application/json",
            "Authorization":"Bearer ${DefaultSetting.user.accessToken}"
          },
          contentType: "application/json"
      ),
      data: jsonEncode({
        "product_id":productId,
      })
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
