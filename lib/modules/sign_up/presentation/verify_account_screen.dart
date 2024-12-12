import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/app_colors.dart';
import '../../../core/size_config.dart';
import '../../../core/waiting_widget.dart';
import '../../../widget/custom_button.dart';
import '../controllers/verify_account_controller.dart';
import 'verify_account_state.dart';

class VerifyAccountScreen extends StatelessWidget {
  VerifyAccountController controller = Get.find();
  static const String routeName = '/VerifyAccountScreenRouteName';
  static const String pageIdentifier = 'VerifyAccountScreenIdentifier';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ScaffoldMessenger(
      key: controller.scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: 1.sh,
            width: 1.sw,
            child: Stack(
              children: [
                // GestureDetector(
                //   onTap: (){
                //     Get.back();
                //   },
                //   child: PositionedDirectional(
                //     start: 20,
                //     top: 20,
                //     child: Icon(
                //       Icons.arrow_back,
                //       color: AppColors.black,
                //       size: 30.w,
                //     ),
                //   ),
                // ),
                Center(
                  child: Container(
                    height: 1.sh,
                    width: 0.8.sw,
                    child: Align(
                      alignment: Alignment.center,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Center(
                            child: Text(
                              "verify_account".tr,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: "BahijBold",
                                color: AppColors.greyTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(40),
                          ),
                          Center(
                            child: Text(
                              "verify_account_desc".tr,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontFamily: "BahijRegular",
                                color: AppColors.greyTextColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(40),
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: PinCodeTextField(
                              appContext: context,
                              length: 6,
                              controller: controller.pinCodeController,
                              onChanged: (v) {
                                controller.validatePinCode();
                              },
                              keyboardType: TextInputType.number,
                              cursorColor: AppColors.greenTextColor,
                              animationType: AnimationType.slide,
                              animationDuration: const Duration(milliseconds: 300),
                              boxShadows: const [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                )
                              ],
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeFillColor: Colors.white,
                                selectedColor: AppColors.greenTextColor,
                                activeColor: AppColors.gold,
                                errorBorderColor: Colors.transparent,
                                inactiveFillColor: AppColors.white,
                                selectedFillColor: AppColors.white,
                                inactiveColor: AppColors.greyTextColor,
                                borderWidth: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(35),
                          ),
                          Obx(() {
                            if (controller.pageState.value ==
                                VerifyAccountState.verifyLoading) {
                              return getWaitingWidget(
                                  VerifyAccountScreen.pageIdentifier);
                            } else {
                              return CustomButton(
                                width: 0.8.sw,
                                height: getProportionateScreenHeight(76),
                                text: "verify_account".tr,
                                backgroundColor: AppColors.green,
                                onTap: () async {
                                  controller.verifyTapped();
                                },
                                textStyle: TextStyle(
                                  color: AppColors.greenTextColor,
                                  fontSize: 20.sp,
                                  fontFamily: "BahijBold",
                                ),
                              );
                            }
                          }),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          Center(
                              child: Text(
                            "didn't_receive_code".tr,
                            style: TextStyle(
                              color: AppColors.greenTextColor,
                              fontSize: 16.sp,
                              fontFamily: "BahijRegular",
                            ),
                          )),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          Obx(() {
                            if (controller.pageState.value ==
                                VerifyAccountState.reSendLoading) {
                              return getWaitingWidget(
                                  VerifyAccountScreen.pageIdentifier);
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  controller.resendCodeTapped();
                                },
                                child: Center(
                                  child: Text(
                                    "resend".tr,
                                    style: TextStyle(
                                      color: AppColors.greenTextColor,
                                      fontSize: 16.sp,
                                      fontFamily: "BahijRegular",
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
