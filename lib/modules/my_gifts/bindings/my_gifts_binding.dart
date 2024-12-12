import 'package:get/get.dart';
import '../controllers/my_gifts_controller.dart';

class MyGiftsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MyGiftsController>(MyGiftsController());
  }
}
