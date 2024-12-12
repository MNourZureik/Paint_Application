import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/core/net/response/base_response.dart';
import '/modules/product_details/model/response/product_details_model.dart';
import '../../favorites/services/favorites_service.dart';
import '../services/product_details_service.dart';
import '../presentation/product_details_state.dart';

class ProductDetailsController extends GetxController {
  final _service = ProductDetailsService();
  late BaseResponse baseResponse;
  late ProductDetails productDetails;
  late int productId;
  var isFavorite = false.obs;

  Rx<ProductDetailsState> pageState = ProductDetailsState.loading.obs;

  @override
  void onReady() async {
    productId = Get.arguments;
    await getDetails();
    super.onReady();
  }

  Future<void> getDetails() async {
    pageState.value = ProductDetailsState.loading;

    baseResponse = await _service.getDetails(productId);
    if (baseResponse != null) {
      if (baseResponse.status == 200) {
        productDetails = ProductDetails.fromJson(baseResponse.data);
      } else {}
    }
    if(productDetails.isFavorite!=null){
      isFavorite.value = productDetails.isFavorite!;
    }
    pageState.value = ProductDetailsState.initial;

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

  void refreshData(int id,) async{
    productId=id;
    await getDetails();
  }

}
