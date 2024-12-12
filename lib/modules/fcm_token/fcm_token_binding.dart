import 'package:get/get.dart';

import '/modules/fcm_token/controller.dart';

class FCMTokenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FCMTokenController>(FCMTokenController());
  }
}
