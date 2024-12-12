import 'package:AEC_Mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/core/constans.dart';
import '/modules/product_search/presentation/product_search_screen.dart';
import '/modules/splash/controllers/splash_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/size_config.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/logo.dart';
import '../controllers/account_controller.dart';

class AccountScreen extends StatelessWidget {
  AccountController controller = Get.put(AccountController());

  AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    return Scaffold(body: SafeArea(child: Obx(() {
      if (SplashController.noAuth.value) {
        print("authauht");
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "سجل دخول للمتابعة",
                style: TextStyle(
                  color: AppColors.greenTextColor,
                  fontFamily: "BahijBold",
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
            CustomButton(
              width: 0.8.sw,
              height: getProportionateScreenHeight(76),
              text: "sign_in".tr,
              backgroundColor: AppColors.green,
              onTap: () async {
                Get.offAllNamed('/start');
              },
              textStyle: TextStyle(
                color: AppColors.greenTextColor,
                fontSize: 20.sp,
                fontFamily: "BahijBold",
              ),
            ),
          ],
        );
      } else {
        return Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(80),
                ),
                Center(
                  child: SizedBox(
                    width: .85.sw,
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            SplashController.auth.phoneNumber!,
                            style: TextStyle(
                              color: AppColors.greenTextColor,
                              fontFamily: "BahijBold",
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(25),
                ),
                //Edit Personal Information
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/edit_profile');
                  },
                  child: Center(
                    child: SizedBox(
                      width: .85.sw,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: SvgPicture.asset(
                                  'assets/icons/profile.svg',
                                  color: AppColors.greenTextColor,
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),
                              Text(
                                'edit_personal_info'.tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: "BahijBold",
                                  color: AppColors.greyTextColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          SizedBox(
                            height: 1,
                            width: .85.sw,
                            child: Container(
                              color: AppColors.greenTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                //Edit Password
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/edit_password');
                    },
                    child: SizedBox(
                      width: .85.sw,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: SvgPicture.asset(
                                  'assets/icons/password.svg',
                                  color: AppColors.greenTextColor,
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),
                              Text(
                                'edit_password'.tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: "BahijBold",
                                  color: AppColors.greyTextColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          SizedBox(
                            height: 1,
                            width: .85.sw,
                            child: Container(
                              color: AppColors.greenTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                //Points
                Visibility(
                    visible: true,
                    child: Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed('/my_points');
                            },
                            child: SizedBox(
                              width: .85.sw,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: Image.asset(
                                          'assets/icons/point.png',
                                          color: AppColors.greenTextColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(20),
                                      ),
                                      Text(
                                        'my_points'.tr,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontFamily: "BahijBold",
                                          color: AppColors.greyTextColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  ),
                                  SizedBox(
                                    height: 1,
                                    width: .85.sw,
                                    child: Container(
                                      color: AppColors.greenTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                      ],
                    )),

                //Receipts
                Visibility(
                    visible: true,
                    child: Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed('/bills');
                            },
                            child: SizedBox(
                              width: .85.sw,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: SvgPicture.asset(
                                          'assets/icons/receipts.svg',
                                          color: AppColors.greenTextColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(20),
                                      ),
                                      Text(
                                        'my_receipts'.tr,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontFamily: "BahijBold",
                                          color: AppColors.greyTextColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  ),
                                  SizedBox(
                                    height: 1,
                                    width: .85.sw,
                                    child: Container(
                                      color: AppColors.greenTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                      ],
                    )),

                //buy table
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('buy_table');
                    },
                    child: SizedBox(
                      width: .85.sw,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: SvgPicture.asset(
                                  'assets/icons/grid.svg',
                                  color: AppColors.greenTextColor,
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),
                              Text(
                                DefaultSetting.user.userableType ==
                                        "distributor"
                                    ? "dist_grid".tr
                                    : 'grid'.tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: "BahijBold",
                                  color: AppColors.greyTextColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          SizedBox(
                            height: 1,
                            width: .85.sw,
                            child: Container(
                              color: AppColors.greenTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                //Centres
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed('/distribution_centres');
                    },
                    child: SizedBox(
                      width: .85.sw,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: SvgPicture.asset(
                                  'assets/icons/centres.svg',
                                  color: AppColors.greenTextColor,
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),
                              Text(
                                'centres'.tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: "BahijBold",
                                  color: AppColors.greyTextColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          SizedBox(
                            height: 1,
                            width: .85.sw,
                            child: Container(
                              color: AppColors.greenTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                //My Gifts
                Visibility(
                    visible: true,
                    child: Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed('my_gifts');
                            },
                            child: SizedBox(
                              width: .85.sw,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 35,
                                        height: 35,
                                        child: SvgPicture.asset(
                                          'assets/icons/gift.svg',
                                          color: AppColors.greenTextColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(20),
                                      ),
                                      Text(
                                        'my_gifts'.tr,
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontFamily: "BahijBold",
                                          color: AppColors.greyTextColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  ),
                                  SizedBox(
                                    height: 1,
                                    width: .85.sw,
                                    child: Container(
                                      color: AppColors.greenTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                      ],
                    )),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // controller.logout();
                    },
                    child: SizedBox(
                      width: .85.sw,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.greenTextColor,
                                            width: 2.0)),
                                    child: Center(
                                      child: Icon(
                                        Icons.phone,
                                        color: AppColors.greenTextColor,
                                        size: getProportionateScreenWidth(20),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),
                              Text(
                                ' تواصل معنا :  '.tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: "BahijBold",
                                  color: AppColors.greyTextColor,
                                ),
                              ),
                              Text(
                                '0940000548',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: "BahijBold",
                                  color: AppColors.greyTextColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          SizedBox(
                            height: 1,
                            width: .85.sw,
                            child: Container(
                              color: AppColors.greenTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      controller.logout();
                    },
                    child: SizedBox(
                      width: .85.sw,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppColors.greenTextColor,
                                            width: 2.0)),
                                    child: Center(
                                      child: Icon(
                                        Icons.logout,
                                        color: AppColors.greenTextColor,
                                        size: getProportionateScreenWidth(20),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),
                              Text(
                                'logout'.tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: "BahijBold",
                                  color: AppColors.greyTextColor,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          SizedBox(
                            height: 1,
                            width: .85.sw,
                            child: Container(
                              color: AppColors.greenTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text( appData!.getString("version")!),
                )
              ],
            ),
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
    })));
  }
}
