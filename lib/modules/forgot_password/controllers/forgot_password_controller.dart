import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/constant.dart';

import '../presentation/forgot_password_state.dart';
import '../services/forgot_password_service.dart';
import '/core/net/response/base_response.dart';

class ForgotPasswordController extends GetxController {
  final _service = ForgotPasswordService();
  Rx<ForgotPasswordState> pageState = ForgotPasswordState.initial.obs;
  String phone = '', code = '', newPassword = '', confirmedPassword = '';
  late BaseResponse baseResponse;
  late Map<String, dynamic> passwordChange;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void showInSnackBar(String value) {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
    }
  }

  forgotPassword() async {
    pageState.value = ForgotPasswordState.loading;
    Map<String, dynamic> passwordChange = {
      'phone': phone.replaceFirst('0', '963'),
    };
    baseResponse = await _service.forgotPassword(passwordChange);
    print(baseResponse.success);
    print(baseResponse.status);
    print(baseResponse.data);
    pageState.value = ForgotPasswordState.success;
    if (baseResponse.status == 200 && baseResponse.success == true) {
      showInSnackBar("Password changed Successfully");
      await Future.delayed(const Duration(milliseconds: 1000));
      print('success ');
    } else {
      showInSnackBar(baseResponse.error);
    }
  }

  verifyCode() async {
    pageState.value = ForgotPasswordState.loading;
    print('phone : $phone');
    passwordChange = {
      'phone_number': gPhone,
      'code': code,
    };
    baseResponse = await _service.verifyCode({
      'phone_number': phone,
      'code': code,
    });
    print(baseResponse.success);
    print(baseResponse.status);
    print(baseResponse.data);
    pageState.value = ForgotPasswordState.otpSuccess;
    if (baseResponse.status == 200 && baseResponse.success == true) {
      showInSnackBar("Password changed Successfully");
      await Future.delayed(const Duration(milliseconds: 1000));
    } else {
      showInSnackBar(baseResponse.error);
    }
  }

  resetPassword() async {
    pageState.value = ForgotPasswordState.loading;
    passwordChange = {
      'phone_number': gPhone,
      'code': gCode,
      'password': newPassword,
      'password_confirmation': confirmedPassword,
    };
    baseResponse = await _service.restPassword(passwordChange);
    log(baseResponse.success.toString());
    log(baseResponse.status.toString());
    log(baseResponse.data.toString());

    pageState.value = ForgotPasswordState.resetSuccess;
    log('________________________________________________________________');
    if (baseResponse.success == true) {
      log('==========================================================');

      showInSnackBar("Password changed Successfully");
      await Future.delayed(const Duration(milliseconds: 1000));
      pageState.value = ForgotPasswordState.resetSuccess;
      Get.offAllNamed("/sign_in");
    } else {
      log("error");
      showInSnackBar("error");
    }
  }
}
