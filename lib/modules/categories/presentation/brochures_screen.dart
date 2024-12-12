import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../core/waiting_widget.dart';
import '../../../widget/logo.dart';
import '../controllers/brochures_controller.dart';
import 'brochures_state.dart';

class BrochuresScreen extends StatelessWidget {
  BrochuresController controller = Get.find();
  static const String routeName = '/BrochuresScreenRouteName';
  static const String pageIdentifier = 'BrochuresScreenIdentifier';

  BrochuresScreen({super.key});

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
          if (controller.pageState.value == BrochuresState.loading) {
            return getWaitingWidget(pageIdentifier);
          } else if (controller.noBrochures.value) {
            return Center(
              child: Text(
                "لا يوجد نشرات فنية تابعة لهذه الفئة",
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
                SizedBox(
                  height: .7.sh,
                  child: ListView.builder(
                      itemCount: controller.brochures.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            SizedBox(
                              width: .9.sw,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: .75.sw,
                                    child: Text(
                                      controller.brochures[index].name,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Uri uri = Uri.parse(
                                          controller.brochures[index].link);
                                      launchUrl(uri,
                                          mode: LaunchMode.externalApplication);
                                    },
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset(
                                          'assets/icons/download_file.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            )
                          ],
                        );
                      }),
                ),
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
