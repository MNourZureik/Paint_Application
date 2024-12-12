import 'package:get/get.dart';
import '/modules/categories/model/response/category.dart';
import '../../product_details/model/response/product_details_model.dart';
import '../services/category_service.dart';
import '../presentation/category_state.dart';
import '../../../core/net/response/base_response.dart';

class CategoryController extends GetxController {
  final _service = CategoryService();
  Rx<CategoryState> pageState = CategoryState.loading.obs;
  late BaseResponse baseResponse;
  late SubCategory subCategory;
  late int subCategoryId;
  late List<Brochure> brochures;
  double aspectRatio=.8;
  var noSub=false.obs;

  @override
  void onInit() {
    var data=Get.arguments;
    subCategoryId=data[0];
    brochures=data[1];
    getSubCategory();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  getSubCategory()async{
    baseResponse=await _service.getSubCategory(subCategoryId);
    if(baseResponse!=null){
      if(baseResponse.status==200){
        if(baseResponse.success==true){
          subCategory=SubCategory.fromJson(baseResponse.data);
          if(subCategory.categories==null||subCategory.categories.isEmpty){
            noSub(true);
          }
        }
      }
    }
    pageState.value=CategoryState.initial;
  }

  refreshData(int id) async{
    pageState.value=CategoryState.loading;
    baseResponse=await _service.getSubCategory(id);
    if(baseResponse!=null){
      if(baseResponse.status==200){
        if(baseResponse.success==true){
          subCategory=SubCategory.fromJson(baseResponse.data);
          if(subCategory.categories==null||subCategory.categories.isEmpty){
            noSub(true);
          }
        }
      }
    }
    pageState.value=CategoryState.initial;
  }

}
