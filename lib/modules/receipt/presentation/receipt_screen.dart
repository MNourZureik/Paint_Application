import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '/core/net/app_urls.dart';
import '/core/net/http_client.dart';
import '/core/net/response/base_response.dart';
import '/modules/splash/controllers/splash_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../widget/logo.dart';
import '../controllers/receipt_controller.dart';

class ReceiptScreen extends StatelessWidget {
  ReceiptController controller = Get.put(ReceiptController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    controller.context=context;
    return ScaffoldMessenger(
      key: controller.scaffoldKey,
      child: Scaffold(
          body: SafeArea(
              child: Obx((){
                if(SplashController.noAuth.value){
                  return  Center(child:  Text(
                    "سجل دخول للمتابعة",
                    style: TextStyle(
                      color: AppColors.greenTextColor,
                      fontFamily: "BahijBold",
                      fontSize: 20.sp,
                    ),
                  ),);
                }else{
                  return Stack(
                    children: [
                      ListView(
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(150),
                          ),
                          Center(
                            child: SizedBox(
                              width: .5.sw,
                              height: getProportionateScreenHeight(200),
                              child: SvgPicture.asset(
                                'assets/icons/scan.svg',
                                color: AppColors.greenTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(40),
                          ),
                          Center(
                            child: SizedBox(
                              width: .5.sw,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      controller.uploadPicture(1);
                                    },
                                    child: SizedBox(
                                      width: getProportionateScreenWidth(50),
                                      height: getProportionateScreenWidth(50),
                                      child: SvgPicture.asset(
                                        "assets/icons/camera_icon.svg",
                                        color: AppColors.greenTextColor,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      controller.uploadPicture(0);
                                    },
                                    child: SizedBox(
                                      width: getProportionateScreenWidth(50),
                                      height: getProportionateScreenWidth(50),
                                      child: SvgPicture.asset(
                                        "assets/icons/gallery.svg",
                                        color: AppColors.greenTextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                  );
                }
              })
          )),
    );
  }
}
