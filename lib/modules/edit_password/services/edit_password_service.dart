import 'dart:convert';

import 'package:dio/dio.dart';
import '/app_config/default_settings.dart';
import '/modules/edit_password/model/request/password_change.dart';
import 'package:http/http.dart' as http;

import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../../../core/net/constants.dart';

class EditPasswordService {
  final _apiRepo = BaseRepository();

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

  Future<dynamic> changePassword(PasswordChange passwordChange) async {
    var url = APIUrls.BASE_URL + APIUrls.changePassword;
    print(passwordChange.confirmedPassword);
    print(passwordChange.oldPassword);
    print(passwordChange.newPassword);
    var response = await _apiRepo.requestApi(
      method: APIType.POST,
      url: url,
      data: jsonEncode({
        "old_password": passwordChange.oldPassword,
        "new_password": passwordChange.newPassword,
        "new_confirm_password": passwordChange.confirmedPassword,
      }),
      options: Options(headers: {
        "accept": "application/json",
        "content-type": "application/json",
        "Authorization": "Bearer ${DefaultSetting.user.accessToken}"
      }, contentType: "application/json"),
    );
    print(response.data);
    return response;
  }

}
