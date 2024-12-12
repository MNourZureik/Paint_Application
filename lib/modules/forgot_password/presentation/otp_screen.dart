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

class OtpScreen extends StatelessWidget {
  final ForgotPasswordController controller = Get.find();

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
                  CustomInputField(
                    width: .8.sw,
                    height: getProportionateScreenHeight(50),
                    onChanged: (val) {
                      controller.code = val;
                    },
                    hintText: "رمز التحقق".tr,
                    maxLength: 10,
                    isGrey: true,
                    textInputType: TextInputType.number,
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
                    text: "تأكيد".tr,
                    backgroundColor: AppColors.green,
                    onTap: () async {
                      gCode = controller.code;
                      await controller.verifyCode();
                      if (controller.pageState.value ==
                          ForgotPasswordState.otpSuccess) {
                      Get.offNamed('/new_password');
                      }
                    },
                    textStyle: TextStyle(
                      color: AppColors.greenTextColor,
                      fontSize: 20.sp,
                      fontFamily: "BahijBold",
                    ),
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
