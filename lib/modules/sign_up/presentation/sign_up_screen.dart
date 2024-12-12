import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/core/waiting_widget.dart';
import '/modules/sign_up/model/request/sign_up_data.dart';
import '../../../core/app_colors.dart';
import '../../../core/size_config.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_input_field.dart';
import '../../../widget/logo1.dart';
import '../../account/model/response/citities_model.dart';
import '../controllers/sign_up_controller.dart';
import 'sign_up_state.dart';

class SignUpScreen extends StatelessWidget {
  SignUpController controller = Get.find();
  static const String routeName = '/SignUpScreenRouteName';
  static const String pageIdentifier = 'SignUpScreenIdentifier';

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ScaffoldMessenger(
      key: controller.scaffoldKey,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(child: Obx(() {
          if (controller.pageState.value == SignUpState.loading) {
            return getWaitingWidget(SignUpScreen.pageIdentifier);
          } else {
            return Stack(
              children: [
                ListView(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Logo1(
                            width: 0.6.sw,
                            height: 0.2.sh,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          CustomInputField(
                            width: .8.sw,
                            height: getProportionateScreenHeight(50),
                            onChanged: (val) {
                              controller.fstName = val;
                            },
                            hintText: "first_name".tr,
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
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          CustomInputField(
                            width: .8.sw,
                            height: getProportionateScreenHeight(50),
                            onChanged: (val) {
                              controller.lstName = val;
                            },
                            hintText: "last_name".tr,
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
                          SizedBox(
                            height: getProportionateScreenHeight(20),
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
                            height: getProportionateScreenHeight(20),
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
                            height: getProportionateScreenHeight(20),
                          ),
                          CustomInputField(
                            width: .8.sw,
                            height: getProportionateScreenHeight(50),
                            onChanged: (val) {
                              controller.passwordConfirmation = val;
                            },
                            isGrey: true,
                            hintText: "confirmed_password".tr,
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
                            height: getProportionateScreenHeight(20),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36)),
                                color: AppColors.upperNavBarBackgroundColor,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              constraints: BoxConstraints(
                                maxHeight: 60,
                                maxWidth: .8.sw,
                                minHeight: 60,
                                minWidth: .8.sw,
                              ),
                              child: Center(
                                child: DropdownSearch<City>(
                                  compareFn: (item1, item2) {
                                    return true;
                                  },
                                  clickProps: const ClickProps(
                                      // icon: Icon(
                                      //   Icons.arrow_drop_down,
                                      //   color: AppColors.greenTextColor,
                                      //   size: 30,
                                      // ),
                                      ),
                                  itemAsString: (c) {
                                    return controller.getNameByLang(c);
                                  },
                                  filterFn: (city, text) {
                                    return city == null
                                        ? true
                                        : controller.applyFilter(city, text);
                                  },
                                  // searchFieldProps: TextFieldProps(
                                  //     cursorColor: AppColors.greenTextColor,
                                  //     decoration: InputDecoration(
                                  //         contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  //         counterText: "",
                                  //         hintText: "search".tr
                                  //
                                  //     )),
                                  // dropdownSearchBaseStyle: TextStyle(),
                                  // searchDelay: Duration.zero,
                                  // showSearchBox: true,
                                  // maxHeight: 0.5.sh,
                                  // dropdownSearchTextAlignVertical:
                                  // TextAlignVertical.center,
                                  // mode: Mode.MENU,
                                  items: (string, loadProps) {
                                    return controller.cities.cities;
                                  },
                                  onChanged: (c) {
                                    controller.changeSelectedCity(c!);
                                  },
                                  // showSelectedItems: false,
                                  // dropdownSearchDecoration: InputDecoration.collapsed(
                                  //   hintText: 'city'.tr,
                                  //   hintStyle: TextStyle(
                                  //     fontFamily: "BahijBold",
                                  //     color: AppColors.grey1,
                                  //     fontSize: 14.sp,
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              UnconstrainedBox(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(36)),
                                    color: AppColors.upperNavBarBackgroundColor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  constraints: BoxConstraints(
                                    maxHeight: 60,
                                    maxWidth: .8.sw,
                                    minHeight: 60,
                                    minWidth: .8.sw,
                                  ),
                                  child: Center(
                                    child: DropdownSearch<String>(
                                      clickProps: const ClickProps(
                                          // icon: Icon(
                                          //   Icons.arrow_drop_down,
                                          //   color: AppColors.greenTextColor,
                                          //   size: 30,
                                          // ),
                                          ),
                                      itemAsString: (c) {
                                        return c;
                                      },
                                      filterFn: (work, text) {
                                        return work == null
                                            ? true
                                            : controller.applyWorkFilter(
                                                work, text);
                                      },
                                      items: (string, loadProps) {
                                        return controller.workList;
                                      },
                                      onChanged: (c) {
                                        controller.changeSelectedWork(c);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(25),
                              ),
                            ],
                          ),
                          Obx(() {
                            if (controller.pageState.value ==
                                SignUpState.buttonLoading) {
                              return Container(
                                width: 0.8.sw,
                                height: getProportionateScreenHeight(76),
                                decoration: const BoxDecoration(
                                  color: AppColors.green,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)),
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
                                text: "sign_up".tr,
                                backgroundColor: AppColors.green,
                                onTap: () async {
                                  await signUpClick();
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
                    ),
                  ],
                )
              ],
            );
          }
        })),
      ),
    );
  }

  signUpClick() async {
    if (controller.checkCompletion()) {
      if (controller.checkPassword()) {
        String number =
            controller.phoneNumber.substring(1, controller.phoneNumber.length);
        if (controller.selectedCity.id == -1) {
          controller.showInSnackBar("الرجاء اختيار مدينة");
        } else {
          SignUpData signUpData = SignUpData(
            phoneNumber: number,
            password: controller.password,
            fstName: controller.fstName,
            lstName: controller.lstName,
            cityId: controller.selectedCity.id,
            work: controller.workController.text,
            passwordConfirmation: controller.passwordConfirmation,
          );
          await controller.signUp(signUpData);
        }
      } else {
        controller.showInSnackBar("كلمة السر يجب أن تكون متوافقة");
      }
    } else {
      controller.showInSnackBar("كل الحقول مطلوبة");
    }
  }
}
