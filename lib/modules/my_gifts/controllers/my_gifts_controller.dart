import 'package:get/get.dart';
import '/modules/my_gifts/model/response/gifts.dart';
import '/modules/my_points/model/response/my_points.dart';
import '../services/my_gifts_service.dart';
import '../presentation/my_gifts_state.dart';
import '../../../core/net/response/base_response.dart';

class MyGiftsController extends GetxController {
  final _service = MyGiftsService();
  Rx<MyGiftsState> pageState = MyGiftsState.loading.obs;
  late BaseResponse baseResponse;
  double aspectRatio=.8;
  var noGifts=false.obs;
  late Gifts gifts;

  getGifts() async{
    pageState.value=MyGiftsState.loading;
    baseResponse=await _service.getGifts();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        gifts=Gifts.fromJson(baseResponse.data);
        if(gifts==null||gifts.gifts!.isEmpty){
          noGifts(true);
        }
      }
    }
    pageState.value=MyGiftsState.initial;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    getGifts();
    super.onReady();
  }
}
