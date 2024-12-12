// ignore_for_file: use_key_in_widget_constructors

import 'package:AEC_Mobile/modules/sign_in/presentation/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/constant.dart';
import '/modules/forgot_password/controllers/forgot_password_controller.dart';

import '/core/app_colors.dart';
import '/core/size_config.dart';
import '/widget/custom_button.dart';
import '/widget/custom_input_field.dart';
import '/widget/logo1.dart';
import 'forgot_password_state.dart';

class NewPasswordScreen extends StatelessWidget {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
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
                    CustomInputField(
                      width: .8.sw,
                      height: getProportionateScreenHeight(50),
                      onChanged: (val) {
                        controller.newPassword = val;
                      },
                      hintText: "الكلمة الجديدة".tr,
                      maxLength: 10,
                      isGrey: true,
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
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    CustomInputField(
                      width: .8.sw,
                      height: getProportionateScreenHeight(50),
                      onChanged: (val) {
                        controller.confirmedPassword = val;
                      },
                      hintText: "تأكيد الكلمة".tr,
                      maxLength: 10,
                      isGrey: true,
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
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    CustomButton(
                      width: 0.4.sw,
                      height: getProportionateScreenHeight(76),
                      text: "save".tr,
                      backgroundColor: AppColors.green,
                      onTap: () {
                        gPassword = controller.newPassword;
                        if (controller.newPassword ==
                            controller.confirmedPassword) {
                          controller.resetPassword();
                        }
                        // if (controller.pageState.value ==
                        //     ForgotPasswordState.resetSuccess) {
                        //   Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(
                        //       builder: (_) => NewPasswordScreen(),
                        //     ),
                        //   );
                        // }
                      },
                      textStyle: TextStyle(
                        color: AppColors.greenTextColor,
                        fontSize: 20.sp,
                        fontFamily: "BahijBold",
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
