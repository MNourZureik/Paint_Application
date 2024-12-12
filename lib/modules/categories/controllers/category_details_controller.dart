import 'package:get/get.dart';
import '/modules/categories/model/response/category_details.dart';
import '../../favorites/services/favorites_service.dart';
import '../../product_details/model/response/product_details_model.dart';
import '../services/category_details_service.dart';
import '../presentation/category_details_state.dart';
import '../../../core/net/response/base_response.dart';

class CategoryDetailsController extends GetxController {
  final _service = CategoryDetailsService();
  Rx<CategoryDetailsState> pageState = CategoryDetailsState.loading.obs;
  late BaseResponse baseResponse;
  late CategoryDetails categoryDetails;
  late int categoryId;
  late List<Brochure> brochures;
  double aspectRatio=.8;
  var noProducts=false.obs;

  @override
  void onInit() {
    var data=Get.arguments;
    categoryId=data[0];
    brochures=data[1];
    getCategoryDetails();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

    getCategoryDetails()async{
      baseResponse=await _service.getCategoryDetails(categoryId);
      print("Id of the caregory is $categoryId");
      if(baseResponse!=null){
        if(baseResponse.status==200){
          if(baseResponse.success==true){
            categoryDetails=CategoryDetails.fromJson(baseResponse.data);
            if(categoryDetails.products==null||categoryDetails.products.isEmpty){
              noProducts(true);
            }
          }
        }
      }
      pageState.value=CategoryDetailsState.initial;
    }

  Future<bool> updateFavorite(id,isFavourite) async{
    isFavourite.value=!isFavourite.value;
    FavoritesService service=FavoritesService();
    baseResponse=await service.updateFavorite(id);
    if(baseResponse!=null){
      if(baseResponse.status==200){
        if(baseResponse.success==true){
          return true;
        }
      }else{
        isFavourite.value=!isFavourite.value;
      }
    }
    return false;
  }

}
