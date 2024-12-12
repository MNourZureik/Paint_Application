import 'package:get/get.dart';
import '../controllers/send_message_controller.dart';

class SendMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SendMessageController>(SendMessageController());
  }
}
