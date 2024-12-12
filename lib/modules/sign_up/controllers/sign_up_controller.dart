import 'dart:developer';

import 'package:AEC_Mobile/core/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/modules/sign_up/model/response/sign_up.dart';
import '../../account/model/response/citities_model.dart';
import '../../sign_in/presentation/sign_in_state.dart';
import '../model/request/sign_up_data.dart';
import '../services/sign_up_service.dart';
import '../presentation/sign_up_state.dart';
import '../../../core/net/response/base_response.dart';

class SignUpController extends GetxController {
  TextEditingController workController = TextEditingController();
  List<String> workList = ['مهندس', 'متعهد دهان'];

  var secureStorage = SecureStorage();
  final _service = SignUpService();
  Rx<SignUpState> pageState = SignUpState.initial.obs;
  late BaseResponse baseResponse;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  String phoneNumber = "",
      password = "",
      passwordConfirmation = "",
      fstName = "",
      lstName = "";
  int cityId = -1;
  late Cities cities;
  City selectedCity = City(id: -1, name: 'name');

  void showInSnackBar(String value) {
    scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  Future<void> signUp(SignUpData signUpData) async {
    pageState.value = SignUpState.buttonLoading;
    baseResponse = await _service.signUp(signUpData);
    if (baseResponse.status == 200) {
      print(baseResponse.status);
      if (baseResponse.success == true) {
        SignUp signUp = SignUp.fromJson(baseResponse.data);
        showInSnackBar("Signed Up successfully");
        await secureStorage.storeValue('verify', 'true');
        await secureStorage.storeValue('phone', signUpData.phoneNumber);
        await secureStorage.storeValue('resend', 'false');
        Get.offAllNamed('/verify_account',
            arguments: [signUpData.phoneNumber, false]);
      }
    } else {
      log(baseResponse.status.toString());
      showInSnackBar(baseResponse.error);
      pageState.value = SignUpState.initial;
    }
    pageState.value = SignUpState.initial;
  }

  @override
  void onInit() {
    pageState.value = SignUpState.loading;
    // workController.text=workController.text!;
    getCities();
    super.onInit();
  }

  bool checkCompletion() {
    return phoneNumber.isNotEmpty &&
        password.isNotEmpty &&
        passwordConfirmation.isNotEmpty &&
        fstName.isNotEmpty &&
        lstName.isNotEmpty &&
        workController.text.isNotEmpty;
  }

  bool checkPassword() {
    return password == passwordConfirmation;
  }

  getNameByLang(City? city) {
    if (city == null) return '';
    return city.name;
  }

  applyFilter(City city, String? text) {
    return city.isContain(text);
  }

  getCities() async {
    baseResponse = await _service.getCities();
    if (baseResponse.status == 200) {
      print(baseResponse.data);
      cities = Cities.fromJson(baseResponse.data);

      pageState.value = SignUpState.initial;
    }
  }

  changeSelectedCity(City city) {
    selectedCity = city;
  }

  applyWorkFilter(String work, String text) {
    if (text.isEmpty) return true;
    if (work.toLowerCase().contains(text.toLowerCase())) return true;

    return false;
  }

  void changeSelectedWork(String? c) {
    switch (c) {
      case 'مهندس':
        {
          workController.text = 'engineer';
          break;
        }
      case 'متعهد دهان':
        {
          workController.text = 'painting_contractor';
          break;
        }
    }
  }
}
