// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:developer';

import 'package:AEC_Mobile/main.dart';
import 'package:AEC_Mobile/modules/account/model/response/citities_model.dart';
import 'package:AEC_Mobile/modules/home_page/presentation/download_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/core/app_colors.dart';
import '/core/size_config.dart';
import '/modules/home_page/presentation/home_page_state.dart';
import '/widget/logo.dart';
import '/widget/product_card.dart';
import '../../../core/constans.dart';
import '../../../widget/centre_card.dart';
import '../controllers/home_page_controller.dart';

class HomePageScreen extends StatelessWidget {
  HomePageController controller = Get.put(HomePageController());

  HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    print(DefaultSetting.user.classification);
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        Obx(() {
          if (controller.pageState.value == HomePageState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(120),
                ),
                // (controller.hasCampaign.value &&
                //         DefaultSetting.user.classification != "")
                //     ?
                //  Visibility(
                //     visible: controller.hasCampaign.value,
                //     child: Center(
                //       child: SizedBox(
                //         width: 0.9.sw,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "about_campaign".tr,
                //               style: TextStyle(
                //                 fontSize: 20.sp,
                //                 fontFamily: "BahijBold",
                //                 color: AppColors.greenTextColor,
                //               ),
                //             ),
                //             SizedBox(
                //               height: getProportionateScreenHeight(15),
                //             ),
                //             Text(
                //               HomePageController.campaign.description!,
                //               style: TextStyle(
                //                 fontSize: 14.sp,
                //                 fontFamily: "BahijPlain",
                //                 color: AppColors.greyTextColor,
                //               ),
                //             ),
                //             SizedBox(
                //               height: getProportionateScreenHeight(25),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   )
                // : Container(),
                !controller.hasCampaign.value
                    ? Center(
                        child: SizedBox(
                          width: .95.sw,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Text(
                                  "no_campaign".tr,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "BahijBold",
                                    fontSize: 24.sp,
                                    color: AppColors.greenTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : isCampaignHasData()
                        ? GetBuilder<HomePageController>(
                            init: HomePageController(),
                            id: 'load_file',
                            builder: (context) {
                              return Compaign();
                            },
                          )
                        : const SizedBox(),
                SizedBox(
                  height: getProportionateScreenHeight(25),
                ),
                Visibility(
                  visible: controller.newProducts.isNotEmpty,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            width: .95.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Text(
                                    "new_arrivals".tr,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "BahijBold",
                                      fontSize: 16.sp,
                                      color: AppColors.green,
                                    ),
                                  ),
                                ),
                                /*SizedBox(
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed('/product_list');
                                                },
                                                child: Text(
                                                  "see_all".tr,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontFamily: "BahijPlain",
                                                    fontSize: 16.sp,
                                                    color: AppColors
                                                        .greenTextColor,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_back_ios_new,
                                                size: getProportionateScreenWidth(
                                                    25),
                                                color: AppColors.greenTextColor,
                                              ),
                                            ],
                                          ),
                                        ),*/
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                            child: GetBuilder<HomePageController>(builder: (_) {
                              return ListView.builder(
                                  itemCount: controller.newProducts.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var added = controller
                                        .newProducts[index].isFavourite.obs;
                                    return Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .3,
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: ProductCard(
                                              onTap: () {
                                                print(
                                                    "id id ${controller.newProducts[index].id}");
                                                Get.toNamed('/product_details',
                                                    arguments: controller
                                                        .newProducts[index].id);
                                              },
                                              width:
                                                  getProportionateScreenWidth(
                                                      175),
                                              height:
                                                  getProportionateScreenHeight(
                                                      225),
                                              name: controller
                                                  .newProducts[index].name,
                                              imageUrl: controller
                                                  .newProducts[index].image,
                                              isFavourite: added.value,
                                              onFavourite: () async {
                                                await controller.updateFavorite(
                                                    controller
                                                        .newProducts[index].id,
                                                    added);
                                              }),
                                        ),
                                        SizedBox(
                                          width:
                                              getProportionateScreenWidth(15),
                                        ),
                                      ],
                                    );
                                  });
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Visibility(
                  visible: controller.mostProducts.isNotEmpty,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            width: .95.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Text(
                                    "most_valued".tr,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "BahijBold",
                                      fontSize: 16.sp,
                                      color: AppColors.green,
                                    ),
                                  ),
                                ),
/*
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed('/product_list');
                                                },
                                                child: Text(
                                                  "see_all".tr,
                                                  textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    fontFamily: "BahijPlain",
                                                    fontSize: 16.sp,
                                                    color: AppColors
                                                        .greenTextColor,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_back_ios_new,
                                                size: getProportionateScreenWidth(
                                                    25),
                                                color: AppColors.greenTextColor,
                                              ),
                                            ],
                                          ),
                                        ),
*/
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * .3,
                              child: GetBuilder<HomePageController>(
                                builder: (_) {
                                  return ListView.builder(
                                      itemCount: controller.mostProducts.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var added = controller
                                            .mostProducts[index]
                                            .isFavourite
                                            .obs;
                                        return Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .4,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .4,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              child: ProductCard(
                                                  onTap: () {
                                                    Get.toNamed(
                                                        '/product_details',
                                                        arguments: controller
                                                            .mostProducts[index]
                                                            .id);
                                                  },
                                                  width:
                                                      getProportionateScreenWidth(
                                                          175),
                                                  height:
                                                      getProportionateScreenHeight(
                                                          225),
                                                  name: controller
                                                      .mostProducts[index].name,
                                                  imageUrl: controller
                                                      .mostProducts[index]
                                                      .image,
                                                  isFavourite: added.value,
                                                  onFavourite: () async {
                                                    await controller
                                                        .updateFavorite(
                                                            controller
                                                                .mostProducts[
                                                                    index]
                                                                .id,
                                                            added);
                                                  }),
                                            ),
                                            SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      15),
                                            ),
                                          ],
                                        );
                                      });
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Obx(() {
                  //! all centers :
                  if (controller.noDistributors.value) {
                    return Container();
                  } else {
                    return SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              width: .95.sw,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      "centres".tr,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: "BahijBold",
                                        fontSize: 16.sp,
                                        color: AppColors.green,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 3, left: 60.0),
                                    child: SizedBox(
                                      child: InkWell(
                                        onTap: () {
                                          showCustomDiaog(context);
                                        },
                                        child: Row(
                                          children: [
                                            GetBuilder<HomePageController>(
                                                init: HomePageController(),
                                                id: "distributors",
                                                builder: (context) {
                                                  return Text(
                                                    controller
                                                        .selectedValue.name,
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: "BahijBold",
                                                      fontSize: 16.sp,
                                                    ),
                                                  );
                                                }),
                                            const SizedBox(width: 8),
                                            const Icon(Icons.filter_list),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                '/distribution_centres');
                                          },
                                          child: Text(
                                            "see_all_centres".tr,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontFamily: "BahijPlain",
                                              fontSize: 16.sp,
                                              color: AppColors.greenTextColor,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_back_ios_new,
                                          size: getProportionateScreenWidth(25),
                                          color: AppColors.greenTextColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GetBuilder<HomePageController>(
                              init: HomePageController(),
                              id: "distributors",
                              builder: (ctr) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .3,
                                    child: ListView.builder(
                                        itemCount: controller
                                            .distributors.distributors!.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            children: [
                                              Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: CentreCard(
                                                    width:
                                                        getProportionateScreenWidth(
                                                            225),
                                                    height:
                                                        getProportionateScreenHeight(
                                                            150),
                                                    name:
                                                        '${controller.distributors.distributors![index].firstName} ${controller.distributors.distributors![index].lastName}',
                                                    address: controller
                                                        .distributors
                                                        .distributors![index]
                                                        .address,
                                                    phoneNumber: controller
                                                        .distributors
                                                        .distributors![index]
                                                        .phone,
                                                  )),
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        15),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                );
                              }),
                        ],
                      ),
                    );
                  }
                })
              ],
            );
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
                                    Get.toNamed('/favorites');
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

  bool isCampaignHasData() {
    return (HomePageController.campaign.description != null &&
            HomePageController.campaign.description!.isNotEmpty) &&
        (HomePageController.campaign.file != null &&
            HomePageController.campaign.file!.isNotEmpty);
  }
}

Widget Compaign() {
  final HomePageController controller = Get.find();
  final path = appData!.getString("campign_file");
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          HomePageController.campaign.description!.tr,
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(width: 10),
        InkWell(
            onTap: () async {
              try {
                DownloadPageState downloadPage = DownloadPageState();
                downloadPage.startDownload(HomePageController.campaign.file!);
              } catch (e) {
                log("Error saving file: $e");
              }
            },
            child: Image.asset("assets/icons/download_file.png",
                width: 30, height: 30)
            // : controller.loader ??
            //     InkWell(
            //       onTap: () {
            //         String fileExtension = path.split('.').last.toLowerCase();

            //         if (fileExtension == 'pdf') {
            //           Get.to(() => PDFViewer(filePath: path));
            //         } else if (['jpg', 'jpeg', 'png', 'gif']
            //             .contains(fileExtension)) {
            //           Get.to(() => ImageViewer(filePath: path));
            //         }
            //       },
            //       child: const Icon(Icons.folder),
            //     ),
            ),
      ],
    ),
  );
}

showCustomDiaog(BuildContext context) {
  HomePageController controller = Get.find();
  showDialog(
    context: context,
    builder: (context) {
      return GetBuilder<HomePageController>(
        init: HomePageController(),
        id: "filter",
        builder: (ctr) {
          return AlertDialog(
            title: Text('Choose an Option'.tr),
            content: SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = controller.cities.cities.length - 1;
                        i > 0;
                        i--)
                      RadioListTile<String>(
                        title: Text(controller.cities.cities[i].name),
                        value: controller.cities.cities[i].name,
                        groupValue: controller.selectedValue.name,
                        onChanged: (value) {
                          for (City city in controller.cities.cities) {
                            if (city.name == value) {
                              controller.selectedValue = city;
                            }
                          }
                          controller.update(['filter']);
                        },
                      ),
                  ],
                  //  controller.cities.cities.map((option) {
                  //   return RadioListTile<String>(
                  //     title: Text(option.name),
                  //     value: option.name,
                  //     groupValue: controller.selectedValue.name,
                  //     onChanged: (value) {
                  //       for (City city in controller.cities.cities) {
                  //         if (city.name == value) {
                  //           controller.selectedValue = city;
                  //         }
                  //       }
                  //       controller.update(['filter']);
                  //     },
                  //   );
                  // }).toList(),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(), // Cancel the dialog
                child: Text("Cancel".tr),
              ),
              TextButton(
                onPressed: () async {
                  if (controller.selectedValue.name == "جميع المراكز") {
                    await controller.getDistributors(false, null);
                  } else {
                    await controller.getDistributors(
                        true, controller.selectedValue.id);
                  }

                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text("Choose".tr),
              ),
            ],
          );
        },
      );
    },
  );
}
