import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/modules/account/model/request/profile_request.dart';
import '../../../core/secure_storage.dart';
import '../model/response/citities_model.dart';
import '../services/edit_profile_service.dart';
import '../presentation/edit_profile_state.dart';
import '../../../core/net/response/base_response.dart';

class EditProfileController extends GetxController {
  final _service = EditProfileService();
  Rx<EditProfileState> pageState = EditProfileState.initial.obs;
  late BaseResponse baseResponse;
  late Cities cities;
  late City selectedCity;

  final GlobalKey<ScaffoldMessengerState> scaffoldKey = new GlobalKey<ScaffoldMessengerState>();
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController selectedCityController=TextEditingController();
  TextEditingController workController=TextEditingController();
  List<String> workList=[
    'Engineer' , 'Painter' , 'Contractor' , 'Workshop Owner'
  ];
//engineer , painter , contractor , workshop_owner


  void showInSnackBar(String value) {
    scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value)));
  }

  getCities()async{
    baseResponse=await _service.getCities();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        print(baseResponse.data);
        cities=Cities.fromJson(baseResponse.data);
        pageState.value=EditProfileState.initial;
      }
    }
  }
  changeSelectedCity(City city){
    selectedCity=city;
    selectedCityController.text=selectedCity.name;
  }
  @override
  void onInit() {
    pageState.value=EditProfileState.loading;
    firstNameController.text=DefaultSetting.user.fstName!;
    lastNameController.text=DefaultSetting.user.lstName!;
    workController.text=DefaultSetting.user.work!;
    selectedCityController.text=DefaultSetting.user.address!;
    super.onInit();
  }

  @override
  void onReady() async {
    await getCities();
    for(City city in cities.cities){
      if(selectedCityController.text==city.name){
        selectedCity=city;
      }
    }
    super.onReady();
  }

  editProfile()async{
    ProfileRequest profileRequest;
    if(DefaultSetting.user.userableType=='member'){
      profileRequest=ProfileRequest(lastName: lastNameController.text, firstName: firstNameController.text, cityId: 1, work: workController.text);
    }else{
      profileRequest=ProfileRequest(lastName: lastNameController.text, firstName: firstNameController.text, cityId: selectedCity.id, work: "");
    }
    BaseResponse response=await _service.editProfile(profileRequest);
    if(response!=null){
      if(response.status==200){
        DefaultSetting.user.address=selectedCityController.text;
        DefaultSetting.user.work=workController.text;
        DefaultSetting.user.fstName=firstNameController.text;
        DefaultSetting.user.lstName=lastNameController.text;
        DefaultSetting.user.saveData();
        showInSnackBar("تم تعديل معلومات حسابك بنجاح");
        Future.delayed(Duration(milliseconds: 1000)).then((value) => Get.back());
      }
    }

  }

  getNameByLang(City? city) {
    if (city == null) return '';
    return city.name;
  }
  applyFilter(City city, String? text) {
    return city.isContain(text);
  }
  applyWorkFilter(String work,String text){
    if(text == null) return true;
    if(text.isEmpty) return true;
    if(work.toLowerCase().contains(text.toLowerCase())) return true;

    return false;
  }
  void changeSelectedWork(String? c) {
    switch (c){
      case "Engineer":{
        workController.text='engineer';
        break;
      }
      case "Painter":{
        workController.text='painter';
        break;
      }
      case "Contractor":{
        workController.text='contractor';
        break;
      }
      case "Workshop Owner":{
        workController.text="workshop_owner";
        break;
      }
    }
  }

}
