import 'package:get/get.dart';

class AppConstants {
  static void goToNotification(){
    Get.toNamed('/notifications',);
  }
  static void goToMessages(){
    Get.toNamed('/administration_messages',);
  }
}
