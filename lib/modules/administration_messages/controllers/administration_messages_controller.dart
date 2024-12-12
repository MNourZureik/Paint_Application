import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/core/net/response/base_response.dart';
import '/modules/administration_messages/model/response/user_messages_to_dist.dart';
import '../model/response/messages.dart';
import '../services/administration_messages_service.dart';
import '../presentation/administration_messages_state.dart';

class AdministrationMessagesController extends GetxController {
  final _service = AdministrationMessagesService();
  Rx<AdministrationMessagesState> pageState =
      AdministrationMessagesState.loading.obs;
  late BaseResponse baseResponse;
  late Messages messages;
  late UserMessagesToDist userMessagesToDist;
  var showMessagesType='رسائل الإدارة'.obs;
  var noMessages=false.obs;
  getMessages() async{
    baseResponse=await _service.getMessages();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        print(baseResponse.data['message']);
        if(baseResponse.data['message']=="Unauthenticated."){
          noMessages(true);
        }else{
          messages=Messages.fromJson(baseResponse.data);
        }
        pageState.value=AdministrationMessagesState.initial;

      }else{
        if(baseResponse.status==401){
          noMessages(true);
        }

      }
    }
  }
  getUserMessages() async{
    baseResponse=await _service.getUserMessages();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        print(baseResponse.data);
        if(baseResponse.data['message']=="Unauthenticated."){
          noMessages(true);
        }else{
          userMessagesToDist=UserMessagesToDist.fromJson(baseResponse.data);
        }

      }
    }
  }
  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onReady() async{
    pageState.value=AdministrationMessagesState.loading;

    await getMessages();
    if(DefaultSetting.user.userableType=='distributor'){
      await getUserMessages();
    }
    pageState.value=AdministrationMessagesState.initial;

    super.onReady();
  }

}
