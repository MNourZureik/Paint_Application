import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/modules/forgot_password/presentation/forgot_password_screen.dart';

import '../../../widget/logo1.dart';
import '../controllers/sign_in_controller.dart';
import '/core/app_colors.dart';
import '/core/size_config.dart';
import '/modules/sign_in/model/request/sign_in_data.dart';
import '/modules/sign_in/presentation/sign_in_state.dart';
import '/widget/custom_button.dart';
import '/widget/custom_input_field.dart';

class SignInScreen extends StatelessWidget {
  SignInController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ScaffoldMessenger(
      key: controller.scaffoldKey,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: ListView(
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
                        controller.phoneNumber = val;
                      },
                      hintText: "phone_number".tr,
                      maxLength: 10,
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
                      isGrey: true,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    CustomInputField(
                      width: .8.sw,
                      height: getProportionateScreenHeight(50),
                      onChanged: (val) {
                        controller.password = val;
                      },
                      isGrey: true,
                      hintText: "password".tr,
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
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/forgot_password');
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 40,
                            ),
                            child: Text(
                              'نسيت كلمة المرور؟',
                              style: TextStyle(color: AppColors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      if (controller.pageState.value == SignInState.loading) {
                        return Container(
                          width: 0.8.sw,
                          height: getProportionateScreenHeight(76),
                          decoration: const BoxDecoration(
                            color: AppColors.green,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24.0)),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                            ),
                          ),
                        );
                      } else {
                        return CustomButton(
                          width: 0.8.sw,
                          height: getProportionateScreenHeight(76),
                          text: "sign_in".tr,
                          backgroundColor: AppColors.green,
                          onTap: () async {
                            print("psps");
                            await signInClick();
                          },
                          textStyle: TextStyle(
                            color: AppColors.greenTextColor,
                            fontSize: 20.sp,
                            fontFamily: "BahijBold",
                          ),
                        );
                      }
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  signInClick() async {
    if (controller.checkCompletion()) {
      String number =
          controller.phoneNumber.substring(1, controller.phoneNumber.length);
      SignInData signInData = SignInData(
        phoneNumber: "$number",
        password: controller.password,
      );
      await controller.signIn(signInData);
    } else {
      controller.showInSnackBar("All fields are required.");
    }
  }
}
