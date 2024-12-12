import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../widget/logo.dart';
import '../controllers/my_points_controller.dart';
import '/app_config/default_settings.dart';
import '/widget/custom_button.dart';
import 'my_points_state.dart';

class MyPointsScreen extends StatelessWidget {
  MyPointsController controller = Get.find();

  MyPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    return ScaffoldMessenger(
      key: controller.scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Obx(() {
                if (controller.pageState.value == MyPointsState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.greenTextColor,
                    ),
                  );
                } else {
                  if (controller.noCampaign.value) {
                    return Center(
                      child: Text(
                        "no_points".tr,
                        style: TextStyle(
                            fontFamily: "BahijBold",
                            fontSize: 30.sp,
                            color: AppColors.greenTextColor),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: 1.sh,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(90),
                          ),
                          Center(
                            child: Column(
                              children: [
                                DefaultSetting.user.classification == 'bronze'
                                    ? SvgPicture.asset(
                                        'assets/icons/bronze.svg')
                                    : DefaultSetting.user.classification ==
                                            "silver"
                                        ? SvgPicture.asset(
                                            'assets/icons/silver.svg')
                                        : DefaultSetting.user.classification ==
                                                "gold"
                                            ? SvgPicture.asset(
                                                'assets/icons/gold.svg')
                                            : SvgPicture.asset(
                                                'assets/icons/platinium.svg'),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                                Center(
                                  child: Text(
                                    controller.points.allPoints.toString(),
                                    style: TextStyle(
                                      fontFamily: "BahijBold",
                                      fontSize: 40.sp,
                                      color: AppColors.greenTextColor,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    "points".tr,
                                    style: TextStyle(
                                      fontFamily: "BahijBold",
                                      fontSize: 20.sp,
                                      color: AppColors.greenTextColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                Center(
                                  child: CustomButton(
                                    width: 0.4.sw,
                                    height: getProportionateScreenHeight(76),
                                    text: "send_request".tr,
                                    backgroundColor: AppColors.green,
                                    onTap: () {
                                      if (controller.points.allPoints != null) {
                                        if (controller.points.allPoints! > 0) {
                                          controller
                                              .sendRequest()
                                              .then((value) {
                                            if (controller.pageState.value ==
                                                MyPointsState.success) {
                                              Navigator.maybePop(context);
                                            }
                                          });
                                        }
                                      }
                                    },
                                    textStyle: TextStyle(
                                      color: AppColors.greenTextColor,
                                      fontSize: 20.sp,
                                      fontFamily: "BahijBold",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(15),
                                ),
                                Center(
                                  child: Container(
                                    width: .9.sw,
                                    height: 2.5,
                                    color: AppColors.blue,
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(10),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Center(
                            child: SizedBox(
                              width: .9.sw,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 400,
                                    width: .9.sw,
                                    child: ListView.builder(
                                        itemCount:
                                            controller.steps.value.toInt(),
                                        // physics: ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          print(
                                              '${controller.steps.value.toInt()}');
                                          return Column(
                                            children: [
                                              Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: 150,
                                                        width: 150,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: controller
                                                              .points
                                                              .allGifts[index]
                                                              .image!,
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            controller
                                                                .points
                                                                .allGifts[index]
                                                                .points!,
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontFamily:
                                                                  "BahijBold",
                                                              color: AppColors
                                                                  .greenTextColor,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .incrementQuantities(
                                                                            index);
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .add)),
                                                              Obx(
                                                                () => Text(controller
                                                                    .quantities[
                                                                        index]
                                                                    .toString()),
                                                              ),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .decrementQuantities(
                                                                            index);
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .remove)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }
              }),
              Positioned(
                top: 0.0,
                child: SizedBox(
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
          ),
        ),
      ),
    );
  }
}
