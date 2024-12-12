import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/modules/bills/model/response/dist_bills.dart';
import '../../../core/net/response/base_response.dart';
import '../../bills/model/response/bills.dart';
import '../services/buy_table_service.dart';
import '../presentation/buy_table_state.dart';

class BuyTableController extends GetxController {
  final _service = BuyTableService();
  Rx<BuyTableState> pageState = BuyTableState.loading.obs;
  late BaseResponse baseResponse;
  late Bills bills;
  late DistBills distBills;
  var noBills=false.obs;

  getBills() async{
    pageState.value=BuyTableState.loading;
    baseResponse=await _service.getBills();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        bills=Bills.fromJson(baseResponse.data);
        if(bills==null||bills.bills!.isEmpty){
          noBills(true);
        }
      }
    }
    pageState.value=BuyTableState.initial;
  }
  getDistBills() async{
    pageState.value=BuyTableState.loading;

    baseResponse=await _service.getDistBills();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        distBills=DistBills.fromJson(baseResponse.data);
        if(distBills==null||distBills.bills!.isEmpty){
          print("asjdfas");
          noBills(true);
        }
      }
    }
    pageState.value=BuyTableState.initial;

  }

  @override
  void onReady() async{
    if(DefaultSetting.user.userableType=='distributor'){
      await getDistBills();
    }else{
      await getBills();

    }
    super.onReady();
  }

}
