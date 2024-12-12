import 'package:get/get.dart';
import '../controllers/distribution_centres_controller.dart';

class DistributionCentresBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DistributionCentresController>(DistributionCentresController());
  }
}
