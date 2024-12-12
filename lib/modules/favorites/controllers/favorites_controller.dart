import 'package:get/get.dart';
import '/core/net/response/base_response.dart';
import '../model/response/favorites_model.dart';
import '../services/favorites_service.dart';
import '../presentation/favorites_state.dart';

class FavoritesController extends GetxController {
  final _service = FavoritesService();
  double aspectRatio=.68;
  late BaseResponse baseResponse;
  late Favorites favorites = Favorites();
  var emptyList=false.obs;
  var error='';
  Rx<FavoritesState> pageState = FavoritesState.loading.obs;


  @override
  void onReady() async{
    await getFavorites();
    super.onReady();
  }


  getFavorites({load=true})async{
    if(load){
      pageState.value=FavoritesState.loading;
    }
    baseResponse=await _service.getProducts();
    if(baseResponse!=null){
      if(baseResponse.status==200){
        favorites=Favorites.fromJson(baseResponse.data);
        if(favorites.products==null||favorites.products!.isEmpty){
          emptyList(true);
        }
      }else{
        error="Error, try again";
      }
    }else{
      error="Error, try again";
    }
    pageState.value=FavoritesState.initial;

  }
  Future<bool> updateFavorite(id,isFavourite) async{
    isFavourite.value=!isFavourite.value;
    FavoritesService service=FavoritesService();
    baseResponse=await service.updateFavorite(id);
    if(baseResponse!=null){
      if(baseResponse.status==200){
        if(baseResponse.success==true){
          await getFavorites(load: false);
          return true;
        }else{
          isFavourite.value=!isFavourite.value;
        }
      }
    }
    return false;
  }

}
