import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/modules/administration_messages/model/request/send_message.dart';
import '/modules/administration_messages/model/response/dist_to_send.dart';
import '../../../core/net/response/base_response.dart';
import '../../distribution_centres/model/response/distribution_centres.dart';
import '../services/send_message_service.dart';
import '../presentation/send_message_state.dart';

class SendMessageController extends GetxController {
  final _service = SendMessageService();
  Rx<SendMessageState> pageState = SendMessageState.loading.obs;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey = new GlobalKey<
      ScaffoldMessengerState>();
  String finalReason = '';
  late BaseResponse baseResponse;
  late DistToSend distributors;
  late DistributorToSend finalDistributor;
  List<String> reasons = [
    'استفسار',
    'اعتراض'
  ];
  RxString selectedDest = ''.obs;
  String name = '',
      phoneNumber = '',
      text = '';

  @override
  void onReady() async {
    pageState.value = SendMessageState.loading;
    await getDistributors();
    pageState.value = SendMessageState.initial;
    super.onReady();
  }

  getNameByLang(String? reason) {
    if (reason == null) return '';
    return reason;
  }

  applyFilter(String? text) {
    return reasons.contains(text);
  }

  changeSelectedReason(String reason) {
    if (reason == 'استفسار') {
      finalReason = 'query';
    } else {
      finalReason = 'objection';
    }
  }

  void showInSnackBar(String value) {
    scaffoldKey.currentState!.showSnackBar(
        new SnackBar(content: new Text(value)));
  }

  changeSelectedDist(DistributorToSend distributor) {
    finalDistributor = distributor;
  }

  sendMessage() async {
    if (!checkCompletion()) {
      showInSnackBar("الرجاء تعبئة جميع الحقول");
    } else {
      List<String> ids=[];
      if(DefaultSetting.user.accessToken==null){
        selectedDest.value == 'company'?'':ids.add(finalDistributor.id!.toString());
        SendMessageData sendMessageData = SendMessageData(
            phoneNumber: phoneNumber,
            name: name,
            mtype: finalReason,
            destination: selectedDest.value ,
            text: text,
            recievers: ids
        );
        print(sendMessageData.toString());
        baseResponse = await _service.sendMessage(sendMessageData);
        if (baseResponse != null) {
          if (baseResponse.status == 200) {
            if(baseResponse.success==true){
              showInSnackBar("تم إرسال الرسالة بنجاح");
              Future.delayed(Duration(milliseconds: 1500)).then((value) {
                print("");
                Get.back();
              });
            }
          }
        }
      }else{
        selectedDest.value == 'company'?'':ids.add(finalDistributor.id!.toString());
        SendMessageDataByMember sendMessageData = SendMessageDataByMember(
            mtype: finalReason,
            destination: selectedDest.value ,
            text: text,
            recievers: ids,
        );
        print(sendMessageData.toString());
        baseResponse = await _service.sendMessageByMember(sendMessageData);
        if (baseResponse != null) {
          if (baseResponse.status == 200) {
            if(baseResponse.success==true){
              showInSnackBar("تم إرسال الرسالة بنجاح");
              Future.delayed(Duration(milliseconds: 1500)).then((value) {
                print("");
                Get.back();
              });
            }
          }
        }
      }

    }
  }

  getNameOfDist(DistributorToSend c) {
    if (c == null)
      return '';
    else
      return c.name;
  }

  getDistributors() async {
    baseResponse = await _service.getDistributors();
    if (baseResponse != null) {
      if (baseResponse.status == 200) {
        distributors = DistToSend.fromJson(baseResponse.data);
        if (distributors == null || distributors.distributors!.isEmpty ||
            distributors.distributors == null) {}
        finalDistributor = distributors.distributors[0];
      }
    }
  }

  bool checkCompletion() {
    if(DefaultSetting.user.accessToken==null){
      if (selectedDest.value == 'company') {
        print(text.isNotEmpty);
        return phoneNumber.isNotEmpty && name.isNotEmpty &&
            selectedDest.value.isNotEmpty && text.isNotEmpty &&
            finalReason.isNotEmpty;
      } else if (selectedDest.value == 'dist'||selectedDest.value=='both') {
        if (finalDistributor == null) {
          return false;
        }
        return phoneNumber.isNotEmpty && name.isNotEmpty &&
            selectedDest.value.isNotEmpty && text.isNotEmpty &&
            finalDistributor != null && finalReason.isNotEmpty;
      }
      return false;
    }else{
      if (selectedDest.value == 'company') {
        print(text.isNotEmpty);
        return
            selectedDest.value.isNotEmpty && text.isNotEmpty &&
            finalReason.isNotEmpty;
      } else if (selectedDest.value == 'dist'||selectedDest.value=='both') {
        if (finalDistributor == null) {
          return false;
        }
        return
            selectedDest.value.isNotEmpty && text.isNotEmpty &&
            finalDistributor != null && finalReason.isNotEmpty;
      }
      return false;
    }

  }

  void changeSelectedDest(int i) {
    switch(i){
      case 1:{
        if(selectedDest.value=='both'){
          selectedDest.value='dist';
        }else if(selectedDest.value=='dist'){
          selectedDest.value='both';
        }else if(selectedDest.value==''){
          selectedDest.value='company';
        }else{
          selectedDest.value='';
        }
        break;
      }
      case 2:{
        if(selectedDest.value=='both'){
          selectedDest.value='company';
        }else if(selectedDest.value=='company'){
          selectedDest.value='both';
        }else if(selectedDest.value==''){
          selectedDest.value='dist';
        }else{
          selectedDest.value='';
        }
        break;
      }
    }
    print("Current destination is ${selectedDest.value}");
  }

}
