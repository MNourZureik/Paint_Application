import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/net/response/base_response.dart';
import 'fcm_token_services.dart';


enum FCMTokenState {
  initial,
  loading,
  loaded,
  error,
}

class FCMTokenController extends GetxController {
  final _service = FCMTokenServices();
  Rx<FCMTokenState> pageState = FCMTokenState.initial.obs;
  String fcmToken = '';
  late BaseResponse baseResponse;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void showInSnackBar(String value) {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
    }
  }

  sendFCMToken() async {
    pageState.value = FCMTokenState.loading;
    baseResponse = await _service.forgotPassword(fcmToken);

    pageState.value = FCMTokenState.loaded;
    if (baseResponse != null) {
      if (baseResponse.status == 200 && baseResponse.success == true) {
        showInSnackBar("Password changed Successfully");
        await Future.delayed(const Duration(milliseconds: 1000));
        print('success ');
      } else {
        showInSnackBar(baseResponse.error);
      }
    } else {
      showInSnackBar("Error,Try again");
    }
  }
}
