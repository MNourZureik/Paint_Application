import 'package:get/get.dart';
import '../controllers/buy_table_controller.dart';

class BuyTableBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BuyTableController>(BuyTableController());
  }
}
