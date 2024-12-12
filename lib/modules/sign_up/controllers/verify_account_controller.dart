import 'package:AEC_Mobile/core/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/modules/sign_in/presentation/sign_in_state.dart';
import '/modules/sign_up/model/request/verify_account.dart';
import '../../../core/validator/validator_model.dart';
import '../../../core/validator/validators_method.dart';
import '../services/verify_account_service.dart';
import '../presentation/verify_account_state.dart';
import '../../../core/net/response/base_response.dart';

class VerifyAccountController extends GetxController {
  var secureStorage = SecureStorage();
  final _service = VerifyAccountService();
  Rx<VerifyAccountState> pageState = VerifyAccountState.initial.obs;
  late BaseResponse baseResponse;
  TextEditingController pinCodeController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = new GlobalKey<ScaffoldMessengerState>();
  ValidatorModel pinCodeValidator = ValidatorModel(errorMessage: ''.obs, isError: true.obs);
  late String phoneNumber;
  late bool resend;
  @override
  void onInit() {
    var data=Get.arguments;
    phoneNumber=data[0];
    resend=data[1];
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  ///UI CONTROLS
  validatePinCode() {
    pinCodeValidator.errorMessage.value =
        Validators.validatePinCode(pinCodeController.text);
    pinCodeValidator.isError.value = pinCodeValidator.errorMessage.value != '';
  }
  void showInSnackBar(String value) {
    scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value)));
  }

  resendCodeTapped(){
    reSendCode();
  }

  reSendCode() async {
    pageState.value=VerifyAccountState.reSendLoading;
    BaseResponse resendCode=await _service.reSendCode(phoneNumber);
    if(resendCode!=null){
      if(resendCode.status==200){
        showInSnackBar("تم إرسال الرمز مجددا");
      }
    }
    pageState.value=VerifyAccountState.initial;
  }
  verifyTapped(){
    if(pinCodeValidator.isError.value){
      showInSnackBar(pinCodeValidator.errorMessage.value);
    }
    else{
      verifyAccount();
    }
  }

  verifyAccount() async{
    String number=phoneNumber;
    print(pinCodeController.text);
    VerifyCode code=VerifyCode(phoneNumber: '$number', code: pinCodeController.text);
    pageState.value=VerifyAccountState.verifyLoading;
    baseResponse=await _service.verify(code);
    if(baseResponse!=null){
      if(baseResponse.status==200){
        print(baseResponse.status);
        if(baseResponse.success==true){
          secureStorage.deleteValue('verify');
          showInSnackBar("Verified successfully");
          Get.offNamed('/sign_in');
        }
      }else{
        showInSnackBar('الرمز خاطئ');
        pageState.value=VerifyAccountState.initial;
      }
    }else{
      showInSnackBar("No Internet Connection");
      pageState.value=VerifyAccountState.initial;
    }
  }

}
