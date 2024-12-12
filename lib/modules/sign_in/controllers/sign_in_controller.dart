import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/core/net/app_urls.dart';
import '/core/net/response/base_response.dart';
import '/modules/sign_in/model/request/sign_in_data.dart';
import '/modules/splash/controllers/splash_controller.dart';
import '../../splash/model/response/auth.dart';
import '../model/response/user_model.dart';
import '../services/sign_in_service.dart';
import '../presentation/sign_in_state.dart';
import 'package:http/http.dart' as http;


class SignInController extends GetxController {
  final _service = SignInService();
  Rx<SignInState> pageState = SignInState.initial.obs;
  late User user;
  late BaseResponse response;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = new GlobalKey<ScaffoldMessengerState>();
  String phoneNumber="",password="";
  late BaseResponse baseResponse;



  void showInSnackBar(String value) {
    scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future<void> signIn(SignInData signInData) async{
    pageState.value=SignInState.loading;
    response=await _service.signIn(signInData);
    print(response.status);
    print(signInData.toJson());
    if(response!=null){
      if(response.status==200){
        print(response.status);
        user=User.fromJson(response.data);
        if(user.userableType!="observer"){
          user.saveData();
          DefaultSetting.user=user;
          DefaultSetting.userType="memmber";
          showInSnackBar("Signed in successfully");
          checkAuth();
        }else{
          showInSnackBar('هذا التطبيق غير خاص للمراقبين');
        }
      }else if (response.status==406){
        print(signInData.phoneNumber);
        Get.toNamed(
            '/verify_account',arguments:[signInData.phoneNumber,false]
        );
      }
      else{
        showInSnackBar(response.error);
        pageState.value=SignInState.initial;
      }
    }else{
      showInSnackBar("No Internet Connection");
      pageState.value=SignInState.initial;
    }
    pageState.value=SignInState.initial;

  }



  bool checkCompletion(){
    return phoneNumber.isNotEmpty&&password.isNotEmpty;
  }
  checkAuth()async{
    if(DefaultSetting.user!=null&&DefaultSetting.user.accessToken!=null){
      baseResponse=await _service.checkAuth(DefaultSetting.user.accessToken!);
      if(baseResponse!=null){
        if(baseResponse.status==200){
          SplashController.auth=Auth.fromJson(baseResponse.data);
          if(SplashController.auth.isActive==1){
            Get.offAllNamed('/main_app');
            SplashController.noAuth(false);
          }else{
            Get.toNamed('/start');
            SplashController.noAuth(true);
          }
        }
          else{
          Get.toNamed('/start');
          SplashController.noAuth(true);
        }
      }else{
        Get.toNamed('/start');
        SplashController.noAuth(true);
      }
    }else{
      Get.toNamed('/start');
      SplashController.noAuth(true);
    }

  }

}
