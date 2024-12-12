import 'package:get/get.dart';
import '../services/start_service.dart';
import '../presentation/start_state.dart';

class StartController extends GetxController {
  final _service = StartService();
  Rx<StartState> pageState = StartState.initial.obs;
}
