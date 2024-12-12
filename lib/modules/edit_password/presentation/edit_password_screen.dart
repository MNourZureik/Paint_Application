import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_input_field.dart';
import '../controllers/edit_password_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/core/constans.dart';
import '../../../core/app_colors.dart';
import '../../../core/size_config.dart';
import '../../../widget/logo.dart';
class EditPasswordScreen extends StatelessWidget {
  EditPasswordController controller = Get.find();
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
                  ListView(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(80),
                      ),
                      Center(
                        child: Text(
                          "${DefaultSetting.user.phoneNumber}",
                          style: TextStyle(
                            color:AppColors.greenTextColor,
                            fontFamily: "BahijBold",
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25),
                      ),
                      Center(
                        child: Text(
                          "${DefaultSetting.user.fstName}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: "BahijBold",
                            color:AppColors.greenTextColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Center(
                        child: Text(
                          "${DefaultSetting.user.work}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: "BahijBold",
                            color:AppColors.greenTextColor,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Center(
                        child: CustomInputField(
                          width: .8.sw,
                          height: getProportionateScreenHeight(50),
                          onChanged: (val) {
                            controller.oldPassword=val;
                          },
                          hintText: "old_password".tr,
                          isPassword:true,
                          textInputType: TextInputType.text,
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "BahijBold",
                            color: AppColors.grey2,
                          ),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "BahijBold",
                            color: AppColors.black,
                          ),
                          isGrey: true,

                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25),
                      ),
                      Center(
                        child: CustomInputField(
                          width: .8.sw,
                          height: getProportionateScreenHeight(50),
                          onChanged: (val) {
                            controller.newPassword=val;
                          },
                          textInputType: TextInputType.text,
                          isGrey: true,
                          hintText: "new_password".tr,
                          isPassword: true,
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "BahijBold",
                            color: AppColors.grey2,
                          ),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "BahijBold",
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(25),
                      ),
                      Center(
                        child: CustomInputField(
                          width: .8.sw,
                          height: getProportionateScreenHeight(50),
                          onChanged: (val) {
                            controller.confirmedPassword=val;
                          },
                          textInputType: TextInputType.text,
                          hintText: "confirm_password".tr,
                          isPassword: true,
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "BahijBold",
                            color: AppColors.grey2,
                          ),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: "BahijBold",
                            color: AppColors.black,
                          ),
                          isGrey: true,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Center(
                        child: CustomButton(
                          width: 0.4.sw,
                          height: getProportionateScreenHeight(76),
                          text: "save".tr,
                          backgroundColor: AppColors.green,
                          onTap: () async{
                            await controller.editPassword();
                          },
                          textStyle: TextStyle(
                            color: AppColors.greenTextColor,
                            fontSize: 20.sp,
                            fontFamily: "BahijBold",
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
                                            onTap: () {},
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
              ))),
    );
  }
}
