import 'package:get/get.dart';
import '../../../core/net/response/base_response.dart';
import '../../favorites/services/favorites_service.dart';
import '../../home_page/model/response/products.dart';
import '../services/product_search_service.dart';
import '../presentation/product_search_state.dart';

class ProductSearchController extends GetxController {
  final _service = ProductSearchService();
  Rx<ProductSearchState> pageState = ProductSearchState.initial.obs;
  String search='';
  double aspectRatio=.68;
  var products=Products().obs;
  late BaseResponse baseResponse;


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

  searchForProducts() async{
    baseResponse=await _service.search(search);
    if(baseResponse!=null){
      if(baseResponse.status==200){
        print(baseResponse.data);
        products.value=Products.fromJson(baseResponse.data);
      }
    }
  }

}
