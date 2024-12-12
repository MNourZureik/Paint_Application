import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/core/net/response/base_response.dart';
import '../../sign_in/model/response/user_model.dart';
import '../model/response/citities_model.dart';
import '../services/account_service.dart';
import '../presentation/account_state.dart';

class AccountController extends GetxController {
  final _service = AccountService();
  Rx<AccountState> pageState = AccountState.initial.obs;

  logout(){
    DefaultSetting.user.clearData();
    Get.offAllNamed('splash');
  }
}
