import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/net/response/base_response.dart';
import '/modules/edit_password/model/request/password_change.dart';
import '../services/edit_password_service.dart';
import '../presentation/edit_password_state.dart';

class EditPasswordController extends GetxController {
  final _service = EditPasswordService();
  Rx<EditPasswordState> pageState = EditPasswordState.initial.obs;
  String oldPassword='',newPassword='',confirmedPassword='';
  late BaseResponse baseResponse;
  late PasswordChange passwordChange;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = new GlobalKey<ScaffoldMessengerState>();


  void showInSnackBar(String value) {
    scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value)));
  }
  editPassword() async{
    pageState.value=EditPasswordState.loading;
    passwordChange=PasswordChange(confirmedPassword: confirmedPassword, newPassword: newPassword, oldPassword: oldPassword);
    baseResponse=await _service.changePassword(passwordChange);
    print(baseResponse.success);
    print(baseResponse.status);
    print(baseResponse.data);
    if(baseResponse!=null){
      if(baseResponse.status==200&&baseResponse.success==true){
        showInSnackBar("Password changed Successfully");
        await Future.delayed(const Duration(milliseconds: 1000));
        Navigator.pop(scaffoldKey.currentState!.context);
      }else{
        showInSnackBar(baseResponse.error);
      }
    }else{
      showInSnackBar("Error,Try again");
    }
  }
}
