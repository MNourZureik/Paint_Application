import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/core/waiting_widget.dart';
import '/modules/product_list/presentation/product_list_state.dart';
import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../widget/logo.dart';
import '../../../widget/product_card.dart';
import '../controllers/product_list_controller.dart';

class ProductListScreen extends StatelessWidget {
  ProductListController controller = Get.find();
  static const pageIdentifier='ProductListScreen';

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
                Obx((){
                  if(controller.pageState.value==ProductListState.loading){
                    return getWaitingWidget(pageIdentifier);
                  }else{
                    return ListView(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(90),
                        ),
                        SizedBox(
                          height:
                          .85.sh,
                          child: GridView.builder(
                            itemCount: controller.products.product!.length,
                            shrinkWrap: true,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              childAspectRatio: controller.aspectRatio,
                            ),
                            padding: const EdgeInsets.all(12.0),
                            itemBuilder:
                                (BuildContext context, int index) {
                                  var added=controller.products.product![index].isFavourite.obs;
                                  return Obx((){
                                    return ProductCard(
                                        onTap: () {
                                          Get.toNamed(
                                              '/product_details',
                                              arguments: controller
                                                  .products.product![index]
                                                  .id);
                                        },
                                        width: getProportionateScreenWidth(
                                            175),
                                        height: getProportionateScreenHeight(
                                            225),
                                        name: controller
                                            .products.product![index]
                                            .name,
                                        imageUrl: controller
                                            .products.product![index]
                                            .image,
                                        isFavourite:added.value,
                                        onFavourite: () async {
                                          await controller
                                              .updateFavorite(
                                              controller
                                                  .products.product![index]
                                                  .id,added);

                                        }
                                    );
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
