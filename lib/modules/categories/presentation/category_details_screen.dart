import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../core/waiting_widget.dart';
import '../../../widget/logo.dart';
import '../../../widget/product_card.dart';
import '../controllers/category_details_controller.dart';
import 'category_details_state.dart';

class CategoryDetailsScreen extends StatelessWidget {
  CategoryDetailsController controller = Get.find();
  static const String routeName = '/CategoryDetailsScreenRouteName';
  static const String pageIdentifier = 'CategoryDetailsScreenIdentifier';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Obx(() {
          if (controller.pageState.value == CategoryDetailsState.loading) {
            return getWaitingWidget(pageIdentifier);
          } else if (controller.noProducts.value) {
            return Center(
              child: Text(
                "لا يوجد منتجات تابعة لهذه الفئة",
                style: TextStyle(
                  color: AppColors.greenTextColor,
                  fontFamily: "BahijBold",
                  fontSize: 20.sp,
                ),
              ),
            );
          } else {
            return ListView(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(80),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/category_brochures',arguments: controller.brochures);
                  },
                  child: Center(
                    child: Text(
                      "download_brochures".tr,
                      style: TextStyle(
                        fontFamily: "BahijPlain",
                        fontSize: 16.sp,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: .8.sh,
                  child: GridView.builder(
                    itemCount: controller.categoryDetails.products.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: controller.aspectRatio,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    itemBuilder: (BuildContext context, int index) {
                      var added = false.obs;
                      if (controller
                              .categoryDetails.products[index].isFavorite !=
                          null) {
                        added.value = controller
                                .categoryDetails.products[index].isFavorite ??
                            false;
                      } else {
                        added.value = false;
                      }
                      return Obx(() {
                        return ProductCard(
                            onTap: () {
                              Get.toNamed('/product_details',
                                  arguments: controller
                                      .categoryDetails.products[index].id);
                            },
                            width: getProportionateScreenWidth(175),
                            height: getProportionateScreenHeight(225),
                            name:
                                controller.categoryDetails.products[index].name,
                            imageUrl: controller
                                .categoryDetails.products[index].image[0],
                            isFavourite: added.value,
                            onFavourite: () async {
                              await controller.updateFavorite(
                                  controller.categoryDetails.products[index].id,
                                  added);
                            });
                      });
                    },
                  ),
                )
              ],
            );
          }
        }),
        Positioned(
          top: 0.0,
          child: Container(
            height: getProportionateScreenHeight(70),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: .9.sw,
                    height: getProportionateScreenHeight(50),
                    decoration: const BoxDecoration(
                      color: AppColors.upperNavBarBackgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(36)),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Logo(
                            width: .9.sw,
                            height: getProportionateScreenHeight(200),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(.9, 0),
                          child: SizedBox(
                            width: .25.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/search_products');
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/search_icon.svg",
                                    width: getProportionateScreenWidth(25),
                                    height: getProportionateScreenWidth(25),
                                    color: AppColors.greenTextColor,
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(15),
                                ),
                                GestureDetector(
                                  onTap: AppConstants.goToMessages,
                                  child: SvgPicture.asset(
                                    "assets/icons/messages_icon.svg",
                                    width: getProportionateScreenWidth(20),
                                    height: getProportionateScreenWidth(23),
                                    color: AppColors.greenTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(-.9, 0),
                          child: SizedBox(
                            width: .25.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed('favorites');
                                  },
                                  child: SvgPicture.asset(
                                    "assets/icons/favourite_icon.svg",
                                    width: getProportionateScreenWidth(25),
                                    height: getProportionateScreenWidth(25),
                                    color: AppColors.greenTextColor,
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(15),
                                ),
                                GestureDetector(
                                  onTap: AppConstants.goToNotification,
                                  child: SvgPicture.asset(
                                    "assets/icons/notifications_icon.svg",
                                    width: getProportionateScreenWidth(25),
                                    height: getProportionateScreenWidth(25),
                                    color: AppColors.greenTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    )));
  }
}
