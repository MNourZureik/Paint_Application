import 'package:get/get.dart';
import '/modules/main_app/presentation/main_app_state.dart';
import '../services/main_App_service.dart';


class MainAppController extends GetxController {
  final _service = MainAppService();
  Rx<MainAppState> pageState = MainAppState.initial.obs;
}
