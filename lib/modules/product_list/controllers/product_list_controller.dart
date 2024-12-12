import 'package:get/get.dart';
import '/core/net/response/base_response.dart';
import '../../favorites/services/favorites_service.dart';
import '../../home_page/model/response/products.dart';
import '../services/product_list_service.dart';
import '../presentation/product_list_state.dart';

class ProductListController extends GetxController {
  final _service = ProductListService();
  double aspectRatio=.68;
  Rx<ProductListState> pageState = ProductListState.loading.obs;
  late Products products;
  late BaseResponse baseResponse;
  getProducts() async{
    pageState.value=ProductListState.loading;
    baseResponse=await _service.getProducts();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        print(baseResponse.data);
        products=Products.fromJson(baseResponse.data);
      }
    }
    pageState.value=ProductListState.initial;

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

  @override
  void onReady() {
    getProducts();
    super.onReady();
  }

}
