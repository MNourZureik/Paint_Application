import 'package:get/get.dart';
import '/modules/categories/model/response/categories.dart';
import '../services/categories_service.dart';
import '../presentation/categories_state.dart';
import '../../../core/net/response/base_response.dart';

class CategoriesController extends GetxController {
  final _service = CategoriesService();
  Rx<CategoriesState> pageState = CategoriesState.loading.obs;
  late BaseResponse baseResponse;
  late Categories categories;
  var noCategories=false.obs;
  double aspectRatio=.8;


  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  getCategories() async{
    pageState = CategoriesState.loading.obs;
    baseResponse=await _service.getCategories();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        if(baseResponse.success==true){
          categories=Categories.fromJson(baseResponse.data);
          if(categories.categories==null||categories.categories.isEmpty){
            noCategories(true);
          }
        }
      }
    }
    pageState = CategoriesState.initial.obs;
  }
}
