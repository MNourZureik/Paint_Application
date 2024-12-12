import 'package:dio/dio.dart';
import '/modules/account/model/request/profile_request.dart';

import '../../../app_config/default_settings.dart';
import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class EditProfileService {
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
            "Authorization":"Bearer ${DefaultSetting.user.accessToken}"
          },
          contentType: "application/json"
      ),
    );
    print(response.data);
    return response;
  }
  Future<dynamic> editProfile(ProfileRequest profileRequest) async {
    var url = APIUrls.BASE_URL +APIUrls.editProfile;
    print(profileRequest.toJson());
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      options: Options(
          headers: {
            "accept":"application/json",
            "content-type":"application/json",
            "Authorization":"Bearer ${DefaultSetting.user.accessToken}"
          },
          contentType: "application/json",

      ),
      data: profileRequest.parse(),
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
