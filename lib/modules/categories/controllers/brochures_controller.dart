import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '/modules/product_details/model/response/product_details_model.dart';
import '../services/brochures_service.dart';
import '../presentation/brochures_state.dart';
import '../../../core/net/response/base_response.dart';

class BrochuresController extends GetxController {
  final _service = BrochuresService();
  Rx<BrochuresState> pageState = BrochuresState.initial.obs;
  late BaseResponse baseResponse;
  late List<Brochure> brochures;
  late BuildContext pageContext;
  var noBrochures=false.obs;

  @override
  void onInit() {
    pageState.value=BrochuresState.loading;
    brochures=Get.arguments;
    if(brochures==null||brochures.isEmpty){
      noBrochures(true);
    }
    pageState.value=BrochuresState.initial;

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }
}
