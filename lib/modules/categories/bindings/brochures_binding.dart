import 'package:get/get.dart';
import '../controllers/brochures_controller.dart';

class BrochuresBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BrochuresController>(BrochuresController());
  }
}
