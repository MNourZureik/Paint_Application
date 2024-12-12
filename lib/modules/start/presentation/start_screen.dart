import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/core/app_colors.dart';
import '/core/size_config.dart';
import '/widget/custom_button.dart';
import '/widget/logo1.dart';
import '../controllers/start_controller.dart';

class StartScreen extends StatelessWidget {
  StartController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Logo1(
                    width: 0.7.sw,
                    height: 0.3.sh,
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  CustomButton(
                    width: 0.8.sw,
                    height: getProportionateScreenHeight(76),
                    text: "sign_in".tr,
                    backgroundColor: AppColors.green,
                    onTap: () {
                      Get.toNamed('/sign_in');
                    },
                    textStyle: TextStyle(
                      color: AppColors.greenTextColor,
                      fontSize: 20.sp,
                      fontFamily: "BahijBold",
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  SizedBox(
                      width: 0.8.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "don't have an account".tr,
                            style: TextStyle(
                              color: AppColors.greyTextColor,
                              fontSize: 16.sp,
                              fontFamily: "BahijPlain",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed('sign_up');
                            },
                            child: Text(
                              "sign_up".tr,
                              style: TextStyle(
                                color: AppColors.green,
                                fontSize: 20.sp,
                                fontFamily: "BahijBold",
                              ),
                            ),
                          ),

                        ],
                      )),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  CustomButton(
                    width: 0.8.sw,
                    height: getProportionateScreenHeight(76),
                    text: "continue as guest".tr,
                    backgroundColor: Colors.transparent,
                    onTap: () {
                      DefaultSetting.userType='guest';
                      Get.offAllNamed('/main_app');
                    },
                    textStyle: TextStyle(
                      color: AppColors.greenTextColor,
                      fontSize: 20.sp,
                      fontFamily: "BahijBold",
                    ),
                    hasBorder: true,
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
