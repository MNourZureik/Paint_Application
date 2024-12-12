import 'package:get/get.dart';
import '/core/net/response/base_response.dart';
import '../model/response/distribution_centres.dart';
import '../services/distribution_centres_service.dart';
import '../presentation/distribution_centres_state.dart';

class DistributionCentresController extends GetxController {
  final _service = DistributionCentresService();
  late BaseResponse baseResponse;
  late Distributors distributors;
  var noDistributors = false.obs;
  Rx<DistributionCentresState> pageState = DistributionCentresState.loading.obs;

  @override
  void onReady() async {
    pageState.value = DistributionCentresState.loading;
    await getDistributors();
    pageState.value = DistributionCentresState.initial;
    super.onReady();
  }

  getDistributors() async {
    baseResponse = await _service.getDistributors(false, null);
    if (baseResponse.status == 200) {
      distributors = Distributors.fromJson(baseResponse.data);
      if (distributors.distributors!.isEmpty ||
          distributors.distributors == null) {
        noDistributors(true);
      }
    }
  }
}
