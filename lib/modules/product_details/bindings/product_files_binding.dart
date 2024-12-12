import 'package:get/get.dart';
import '../controllers/product_files_controller.dart';

class ProductFilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProductFilesController>(ProductFilesController());
  }
}
