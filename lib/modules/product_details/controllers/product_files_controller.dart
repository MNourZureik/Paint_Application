import 'package:get/get.dart';
import '/modules/product_details/services/product_details_service.dart';
import '../../favorites/services/favorites_service.dart';
import '../model/response/product_details_model.dart';
import '../services/product_files_service.dart';
import '../presentation/product_files_state.dart';
import '../../../core/net/response/base_response.dart';

class ProductFilesController extends GetxController {
  final _service = ProductFilesService();
  Rx<ProductFilesState> pageState = ProductFilesState.initial.obs;
  late BaseResponse baseResponse;
  late ProductDetails productDetails;
  var isFavorite = false.obs;


  @override
  void onInit() {
    productDetails=Get.arguments;
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }
  Future<bool> updateFavorite(id, added) async {
    FavoritesService service = FavoritesService();
    baseResponse = await service.updateFavorite(id);
    if (baseResponse != null) {
      if (baseResponse.status == 200) {
        if (baseResponse.success == true) {
          await getDetails();
          return true;
        }
      } else {}
    }
    return false;
  }
  Future<void> getDetails() async {
    pageState.value = ProductFilesState.loading;
    ProductDetailsService service=ProductDetailsService();
    baseResponse = await service.getDetails(productDetails.id);
    if (baseResponse != null) {
      if (baseResponse.status == 200) {
        productDetails = ProductDetails.fromJson(baseResponse.data);
        print("Desc is ${baseResponse.data["related_products"][0]["isFavorite"]}");
      } else {}
    }
    if(productDetails.isFavorite!=null){
      isFavorite.value = productDetails.isFavorite!;
    }
    pageState.value = ProductFilesState.initial;

  }

}
