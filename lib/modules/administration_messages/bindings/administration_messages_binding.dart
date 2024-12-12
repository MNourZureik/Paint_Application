import 'package:get/get.dart';
import '../controllers/administration_messages_controller.dart';

class AdministrationMessagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdministrationMessagesController>(
        AdministrationMessagesController());
  }
}
