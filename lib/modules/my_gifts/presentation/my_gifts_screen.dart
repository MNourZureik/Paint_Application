import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../widget/logo.dart';
import '../controllers/my_gifts_controller.dart';
import '/widget/gift_card.dart';
import 'my_gifts_state.dart';

class MyGiftsScreen extends StatelessWidget {
  MyGiftsController controller = Get.find();
  static const pageIdentifier = 'MyGiftsScreen';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(body: Obx(() {
      if (controller.pageState.value == MyGiftsState.loading) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.greenTextColor,
          ),
        );
      } else {
        if (controller.noGifts.value) {
          return Center(
            child: Text(
              "empty_gifts".tr,
              style: TextStyle(
                  fontFamily: "BahijBold",
                  fontSize: 30.sp,
                  color: AppColors.greenTextColor),
            ),
          );
        } else {
          return SafeArea(
              child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(90),
                  ),
                  SizedBox(
                    height: .85.sh,
                    child: GridView.builder(
                      itemCount: controller.gifts.gifts.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: controller.aspectRatio,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      itemBuilder: (BuildContext context, int index) {
                        return GiftCard(
                          width: getProportionateScreenWidth(175),
                          height: getProportionateScreenHeight(225),
                          imageUrl: controller.gifts.gifts[index].giftImage,
                          name: controller.gifts.gifts[index].giftName,
                          date: controller.gifts.gifts[index].date
                              .toString()
                              .substring(0, 10),
                        );
                      },
                    ),
                  )
                ],
              ),
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
                                          width:
                                              getProportionateScreenWidth(25),
                                          height:
                                              getProportionateScreenWidth(25),
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
                                          width:
                                              getProportionateScreenWidth(20),
                                          height:
                                              getProportionateScreenWidth(23),
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
                                          width:
                                              getProportionateScreenWidth(25),
                                          height:
                                              getProportionateScreenWidth(25),
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
                                          width:
                                              getProportionateScreenWidth(25),
                                          height:
                                              getProportionateScreenWidth(25),
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
          ));
        }
      }
    }));
  }
}
