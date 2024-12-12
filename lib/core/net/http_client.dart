import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getP;
import 'package:image_picker/image_picker.dart';

import '../../app_config/default_settings.dart';
import '../../core/net/response/base_response.dart';
import 'app_urls.dart';
import 'constants.dart';

class BaseRepository {
  late Dio _dio;

  Dio get instance => _dio;
  BaseRepository() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(milliseconds: 1500000), // 25 minutes
      receiveTimeout: const Duration(milliseconds: 1500000), // 25 minutes
      sendTimeout: const Duration(milliseconds: 3000000), // 50 minutes
      responseType: ResponseType.json,
      baseUrl: APIUrls.BASE_URL,
    );
    _dio = Dio(options);
  }

  Future<BaseResponse> requestApi({
    required String method,
    required String url,
    String? idToken = '',
    Map<String, dynamic>? queryParam,
    Options? options,
    dynamic data,
  }) async {
    BaseResponse response =
        BaseResponse(status: HTTP_INTERNAL_SERVER_ERROR, success: false);

    try {
      response = await _sendRequest(
        method: method,
        url: url,
        idToken: idToken!,
        queryParam: queryParam,
        options: options,
        data: data,
      );

      return response;
    } catch (e) {
      debugPrint('Error from base repository $e');
      return response;
    }
  }

  Future<BaseResponse> _sendRequest({
    required String method,
    required String url,
    String? idToken,
    Map<String, dynamic>? queryParam,
    Options? options,
    dynamic data,
  }) async {
    try {
      Response apiReturn;

      options ??= Options(
        headers: {},
      );

      if (idToken != null) {
        if (idToken.trim().isNotEmpty)
          options.headers!['Authorization'] = 'Bearer $idToken';
      }
      options.headers!['Accept'] = 'application/json';
      options.headers!['local'] = DefaultSetting.lang;
      if (method == APIType.GET) {
        apiReturn =
            await _dio.get(url, queryParameters: queryParam, options: options);
      } else if (method == APIType.POST) {
        apiReturn = await _dio.post(url,
            queryParameters: queryParam, options: options, data: data);
      } else if (method == APIType.PUT) {
        apiReturn = await _dio.put(url,
            queryParameters: queryParam, options: options, data: data);
      } else {
        apiReturn = await _dio.delete(url,
            queryParameters: queryParam, options: options, data: data);
      }
      print(apiReturn.statusCode);
      print(apiReturn.data);

      return BaseResponse(
        status: apiReturn.data['status_code'],
        success: true,
        data: apiReturn.data['data'],
        errorGeneric: apiReturn.data['errors'] ?? '',
      );
    } on DioException catch (ex) {
      print('eeeeeeeeeeeeerrrrrrrrrrr');

      debugPrint(ex.error as String?);
      debugPrint('Error on request to $url');
      print(ex.response!.data);
      if (ex.type == DioExceptionType.connectionError) {
        //   debugPrint('Error Connection Timeout Exception ${ex.message}');
        // throw Exception("Connection  Timeout Exception");
      } else {
        debugPrint('Error Exception ${ex.message}');
        if (ex.response != null) {
        } else {
          debugPrint('Error $ex');
          debugPrint('Error Message ${ex.message}');
        }
        // throw Exception(ex.message);
      }

      return BaseResponse(
          status: ex.response!.statusCode ?? HTTP_INTERNAL_SERVER_ERROR,
          success: false,
          data: {},
          errorGeneric: ex.response!.data['errors'] ?? 'error500'.tr);
    }
  }

  Future<Response> uploadImage(XFile file, String url) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var response = await _dio.post(
        options: Options(
            headers: {
              "accept": "*/*",
              "content-type":
                  "multipart/form-data; boundary=<calculated when request is sent>",
              'Authorization': "Bearer ${DefaultSetting.user.accessToken}"
            },
            contentType:
                "multipart/form-data; boundary=<calculated when request is sent>"),
        url,
        data: formData);
    print(response);
    return response;
  }
}
