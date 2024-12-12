// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:AEC_Mobile/main.dart';
import 'package:AEC_Mobile/modules/account/model/response/citities_model.dart';
import 'package:AEC_Mobile/modules/sign_up/services/sign_up_service.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import '/core/net/response/base_response.dart';
import '/modules/favorites/services/favorites_service.dart';
import '/modules/home_page/model/response/campaign.dart';
import '../../distribution_centres/model/response/distribution_centres.dart';
import '../../distribution_centres/services/distribution_centres_service.dart';
import '../model/response/products.dart';
import '../services/home_page_service.dart';
import '../presentation/home_page_state.dart';

class HomePageController extends GetxController {
  final _service = HomePageService();
  final _city_service = SignUpService();
  Widget? loader;
  Rx<HomePageState> pageState = HomePageState.loading.obs;
  static late Campaign campaign;
  var hasCampaign = false.obs;
  late BaseResponse baseResponse;
  late Products products;
  late Distributors distributors;
  var noDistributors = false.obs;
  late Cities cities;
  List<Product> newProducts = [], mostProducts = [];
  late City selectedValue;

  @override
  void onReady() async {
    super.onReady();
    pageState.value = HomePageState.loading;
    await getCurrentCampaign();
    await getProducts();
    await getDistributors(false, null);
    await getCities();
    selectedValue = cities.cities[cities.cities.length - 1];
    pageState.value = HomePageState.initial;
  }

  getCities() async {
    baseResponse = await _city_service.getCities();
    if (baseResponse.status == 200) {
      print(baseResponse.data);
      cities = Cities.fromJson(baseResponse.data);
    }
    City city = City(id: -1, name: "جميع المراكز");
    cities.cities.add(city);
  }

  getCurrentCampaign() async {
    baseResponse = await _service.getCurrentCampaign();
    if (baseResponse.status == 200) {
      print(baseResponse.data);
      log(baseResponse.data.toString());
      campaign = Campaign.fromJson(baseResponse.data);
      log("new Compaign $campaign");
      if (campaign.description != null || campaign.description!.isNotEmpty) {
        hasCampaign(true);
      }
      log("url file :${campaign.file}");
    }
    log("${baseResponse.status}status code for current campign");
  }

  getProducts() async {
    baseResponse = await _service.getProducts();
    if (baseResponse.status == 200) {
      print(baseResponse.data);
      products = Products.fromJson(baseResponse.data);
      fetchProducts();
    }
    log("${baseResponse.status}status code for products");
  }

  fetchProducts() {
    newProducts.clear();
    mostProducts.clear();
    for (Product product in products.product!) {
      if (product.isNew == 1) {
        newProducts.add(product);
      }
      if (product.isSuper == 1) {
        mostProducts.add(product);
      }
    }
    update();
  }

  Future<bool> updateFavorite(id, isFavourite) async {
    isFavourite.value = !isFavourite.value;
    FavoritesService service = FavoritesService();
    baseResponse = await service.updateFavorite(id);
    if (baseResponse.status == 200) {
      if (baseResponse.success == true) {
        getProducts();
        return true;
      }
    } else {
      isFavourite.value = !isFavourite.value;
    }
    return false;
  }

  getDistributors(bool isFilter, int? cityId) async {
    BaseResponse distributorsBaseResponse =
        await DistributionCentresService().getDistributors(isFilter, cityId);
    log("dis status :${distributorsBaseResponse.status}");
    log("distributors :${distributorsBaseResponse.data}");
    if (distributorsBaseResponse.status == 200) {
      distributors = Distributors.fromJson(distributorsBaseResponse.data);
      log("distributors :$distributors");
      if (distributors.distributors!.isEmpty ||
          distributors.distributors == null) {
        noDistributors(true);
      }
      update(['distributors']);
    } else {
      log("error dis");
    }
  }

//"https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf"
  // get_campign_file() async {
  //   final filesContent = await FileDownloader.downloadFile(
  //     url: "https://via.placeholder.com/150",
  //     //campaign.file!,
  //     name: "campaign-details.pdf",
  //     subPath: "JUTON/",
  //     onProgress: (String? fileName, double progress) {
  //       log('FILE fileName HAS PROGRESS $progress');
  //       loader = const CircularProgressIndicator();
  //       update(['load_file']);
  //     },
  //     onDownloadCompleted: (String path) {
  //       log('FILE DOWNLOADED TO PATH: $path');
  //       FileDownloader.cancelDownload;
  //       loader = null;
  //       update(['load_file']);
  //     },
  //     onDownloadError: (String error) {
  //       FileDownloader.cancelDownload;
  //     },
  //   ).timeout(const Duration(seconds: 5));
  //   if (filesContent != null) {
  //     appData!.setString("campign_file", filesContent.path);
  //   }
  // }

  @override
  void onClose() {
    // FileDownloader.cancelDownload;
    super.onClose();
  }
}
