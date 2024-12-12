import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/modules/bills/presentation/bills_state.dart';
import 'package:photo_view/photo_view.dart';
import '../../../widget/bill_card.dart';
import '../controllers/bills_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../widget/logo.dart';
import '../../../widget/product_card.dart';

class BillsScreen extends StatelessWidget {
  BillsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    return Scaffold(
        key: controller.scaffoldKey,
        body: Obx(() {
          if (controller.pageState.value == BillsState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.greenTextColor,
              ),
            );
          } else {
            if (controller.noBills.value) {
              return Center(
                child: Text(
                  "empty_bills".tr,
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
                          itemCount: controller.bills.value.bills!.length,
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: controller.aspectRatio,
                          ),
                          padding: const EdgeInsets.all(12.0),
                          itemBuilder: (BuildContext context, int index) {
                            return BillCard(
                              onTap: () {
                                _showMyDialog(
                                    CachedNetworkImage(
                                      imageUrl: controller.bills.value
                                          .bills![index]!.billImage!,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      imageBuilder: (context, imageProvider) =>
                                          PhotoView(
                                        imageProvider: imageProvider,
                                      ),
                                      placeholder: (context, _) =>
                                          ProfileImageShimmerEffect(
                                        width: .9.sw,
                                        height:
                                            getProportionateScreenHeight(225),
                                      ),
                                    ),
                                    controller.scaffoldKey.currentContext,
                                    controller.bills.value.bills![index]!.id!,
                                  controller.bills.value.bills![index]!.billCode==null
                                );
                              },
                              width: getProportionateScreenWidth(175),
                              height: getProportionateScreenHeight(225),
                              imageUrl: controller
                                  .bills.value.bills![index]!.billImage,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36)),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed('/search_products');
                                            },
                                            child: SvgPicture.asset(
                                              "assets/icons/search_icon.svg",
                                              width:
                                                  getProportionateScreenWidth(
                                                      25),
                                              height:
                                                  getProportionateScreenWidth(
                                                      25),
                                              color: AppColors.greenTextColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(15),
                                          ),
                                          GestureDetector(
                                            onTap: AppConstants.goToMessages,
                                            child: SvgPicture.asset(
                                              "assets/icons/messages_icon.svg",
                                              width:
                                                  getProportionateScreenWidth(
                                                      20),
                                              height:
                                                  getProportionateScreenWidth(
                                                      23),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed('favorites');
                                            },
                                            child: SvgPicture.asset(
                                              "assets/icons/favourite_icon.svg",
                                              width:
                                                  getProportionateScreenWidth(
                                                      25),
                                              height:
                                                  getProportionateScreenWidth(
                                                      25),
                                              color: AppColors.greenTextColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                                getProportionateScreenWidth(15),
                                          ),
                                          GestureDetector(
                                            onTap:
                                                AppConstants.goToNotification,
                                            child: SvgPicture.asset(
                                              "assets/icons/notifications_icon.svg",
                                              width:
                                                  getProportionateScreenWidth(
                                                      25),
                                              height:
                                                  getProportionateScreenWidth(
                                                      25),
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

  Future<void> _showMyDialog(widget, context, int id,canDelete) async {
    return showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false, // user must tap button!
      pageBuilder: (_, __, ___) {
        return SafeArea(
          child: Container(
            color: Colors.black,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(.9, -.9),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Icon(Icons.close_rounded),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible:canDelete ,
                  child: Align(
                    alignment: const Alignment(-.9, -.9),
                    child: GestureDetector(
                      onTap: () {
                        controller.deleteBill(id);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    child: Container(
                      width: 1.sw,
                      height: .5.sh,
                      child: widget,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
