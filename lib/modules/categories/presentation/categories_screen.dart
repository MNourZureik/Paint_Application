import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/widget/category_card.dart';
import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../core/waiting_widget.dart';
import '../../../widget/logo.dart';
import '../controllers/categories_controller.dart';
import 'categories_state.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesController controller = Get.put(CategoriesController());
  static const String routeName = '/CategoriesScreenRouteName';
  static const String pageIdentifier = 'CategoriesScreenIdentifier';

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
                  if(controller.pageState.value==CategoriesState.loading){
                    return getWaitingWidget(pageIdentifier);
                  }else{
                    return ListView(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(80),
                        ),
                        SizedBox(
                          height:
                          1.sh-(getProportionateScreenHeight(170)+MediaQuery.of(context).padding.top+MediaQuery.of(context).padding.bottom),
                          child: GridView.builder(
                            itemCount: controller.categories.categories.length,
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
                                  return CategoryCard(
                                    onTap: () {
                                      if(controller
                                          .categories.categories[index].isFinal==1){
                                        Get.toNamed('/category_details',arguments: [controller.
                                            categories.categories[index].id,controller.categories.categories[index].brochure]);
                                      }else{
                                        Get.toNamed('/sub_category',arguments:[controller
                                            .categories.categories[index]
                                            .id,controller.categories.categories[index].brochure] );
                                      }

                                    },
                                    width: getProportionateScreenWidth(
                                        175),
                                    height: getProportionateScreenHeight(
                                        200),
                                    name: controller
                                        .categories.categories[index]
                                        .name,
                                    imageUrl: controller
                                        .categories.categories[index]
                                        .image,
                                  );
                            },
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(70),
                        ),
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
