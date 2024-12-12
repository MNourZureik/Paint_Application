import 'package:get/get.dart';
import '/core/net/response/base_response.dart';
import '/modules/notifications/model/response/notifications.dart';
import '../services/notifications_service.dart';
import '../presentation/notifications_state.dart';

class NotificationsController extends GetxController {
  final _service = NotificationsService();
  Rx<NotificationsState> pageState = NotificationsState.loading.obs;
  late BaseResponse baseResponse;
  late Notifications notifications = Notifications.initial();
  var noNotifications=false.obs;

  @override
  void onReady() {
    getNotifications();
    super.onReady();
  }

  getNotifications() async{
    pageState.value=NotificationsState.loading;
    baseResponse=await _service.getNotifications();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        notifications=Notifications.fromJson(baseResponse.data);
        if(notifications==null||notifications.notifications.isEmpty){
          noNotifications(true);
        }
      }
    }
    pageState.value=NotificationsState.initial;

  }
}
