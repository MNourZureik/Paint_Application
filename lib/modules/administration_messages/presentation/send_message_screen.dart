import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/modules/administration_messages/presentation/send_message_state.dart';
import '/modules/distribution_centres/model/response/distribution_centres.dart';
import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../core/waiting_widget.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_input_field.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/logo.dart';
import '../controllers/send_message_controller.dart';
import '../model/response/dist_to_send.dart';

class SendMessageScreen extends StatelessWidget {
  SendMessageController controller = Get.find();
  static const String pageIdentifier = 'SendMessageScreen';

  SendMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ScaffoldMessenger(
      key: controller.scaffoldKey,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(child: Obx(() {
          if (controller.pageState.value == SendMessageState.loading) {
            return getWaitingWidget(SendMessageScreen.pageIdentifier);
          } else {
            return Stack(
              children: [
                ListView(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                              visible: DefaultSetting.user.accessToken == null,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: getProportionateScreenHeight(20),
                                  ),
                                  CustomInputField(
                                    width: .8.sw,
                                    height: getProportionateScreenHeight(50),
                                    onChanged: (val) {
                                      controller.name = val;
                                    },
                                    hintText: "sender_name".tr,
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
                                ],
                              )),
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
                                child: DropdownSearch<String>(
                                  clickProps: const ClickProps(
                                      // icon: Icon(
                                      //   Icons.arrow_drop_down,
                                      //   color: AppColors.greenTextColor,
                                      //   size: 30,
                                      // ),
                                      ),
                                  // searchFieldProps: TextFieldProps(
                                  //     cursorColor: AppColors.greenTextColor,
                                  //     decoration: InputDecoration(
                                  //         contentPadding:
                                  //             EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  //         counterText: "",
                                  //         hintText: "search".tr)),
                                  // dropdownSearchBaseStyle: TextStyle(),
                                  // searchDelay: Duration.zero,
                                  // showSearchBox: true,
                                  // maxHeight: 0.5.sh,
                                  // dropdownSearchTextAlignVertical:
                                  //     TextAlignVertical.center,
                                  // mode: Mode.MENU,
                                  items: (str, loadProps) {
                                    return controller.reasons;
                                  },
                                  onChanged: (c) {
                                    controller.changeSelectedReason(c!);
                                  },
                                  // // showSelectedItems: false,
                                  // // dropdownSearchDecoration:
                                  //     InputDecoration.collapsed(
                                  //   hintText: 'reason'.tr,
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
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Obx(() {
                            return SizedBox(
                              width: .9.sw,
                              height: 50,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: .4.sw,
                                    height: 50,
                                    child: ListTile(
                                      title: Text(
                                        'الشركة',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontFamily: "BahijRegular",
                                            color: AppColors.greenTextColor),
                                      ),
                                      leading: Checkbox(
                                        activeColor: AppColors.greenTextColor,
                                        onChanged: (val) {
                                          controller.changeSelectedDest(1);
                                        },
                                        value: controller.selectedDest.value ==
                                                "company" ||
                                            controller.selectedDest.value ==
                                                'both',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: .4.sw,
                                    height: 50,
                                    child: ListTile(
                                      title: Text(
                                        'موزع',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontFamily: "BahijRegular",
                                            color: AppColors.greenTextColor),
                                      ),
                                      leading: Checkbox(
                                        activeColor: AppColors.greenTextColor,
                                        onChanged: (val) {
                                          controller.changeSelectedDest(2);
                                        },
                                        value: controller.selectedDest.value ==
                                                "dist" ||
                                            controller.selectedDest.value ==
                                                'both',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          controller.selectedDest == 'dist' ||
                                  controller.selectedDest == "both"
                              ? UnconstrainedBox(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(36)),
                                      color:
                                          AppColors.upperNavBarBackgroundColor,
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
                                      child: DropdownSearch<DistributorToSend>(
                                        clickProps: const ClickProps(
                                            // icon: Icon(
                                            //   Icons.arrow_drop_down,
                                            //   color: AppColors.greenTextColor,
                                            //   size: 30,
                                            // ),
                                            ),
                                        itemAsString: (c) {
                                          return controller.getNameOfDist(c);
                                        },
                                        // searchFieldProps: TextFieldProps(
                                        //     cursorColor: AppColors.greenTextColor,
                                        //     decoration: InputDecoration(
                                        //         contentPadding:
                                        //             EdgeInsets.fromLTRB(
                                        //                 20, 0, 0, 0),
                                        //         counterText: "",
                                        //         hintText: "search".tr)),
                                        // dropdownSearchBaseStyle: TextStyle(),
                                        // searchDelay: Duration.zero,
                                        // showSearchBox: true,
                                        // maxHeight: 0.5.sh,
                                        // dropdownSearchTextAlignVertical:
                                        //     TextAlignVertical.center,
                                        // mode: Mode.MENU,
                                        items: (string, loadProps) {
                                          return controller
                                              .distributors.distributors;
                                        },
                                        onChanged: (c) {
                                          controller.changeSelectedDist(c!);
                                        },
                                        // showSelectedItems: false,
                                        // dropdownSearchDecoration:
                                        //     InputDecoration.collapsed(
                                        //   hintText: 'الموزع'.tr,
                                        //   hintStyle: TextStyle(
                                        //     fontFamily: "BahijBold",
                                        //     color: AppColors.grey1,
                                        //     fontSize: 14.sp,
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: getProportionateScreenHeight(25),
                          ),
                          CustomTextField(
                            maxHeight: 150,
                            maxWidth: .8.sw,
                            minHeight: 150,
                            minWidth: .8.sw,
                            hint: "enter_text".tr,
                            onChanged: (val) {
                              controller.text = val;
                            },
                            textStyle: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "BahijBold",
                              color: AppColors.black,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "BahijBold",
                              color: AppColors.grey2,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Obx(() {
                            if (controller.pageState.value ==
                                SendMessageState.buttonLoading) {
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
                                width: 0.4.sw,
                                height: getProportionateScreenHeight(76),
                                text: "send".tr,
                                backgroundColor: AppColors.green,
                                onTap: () async {
                                  await controller.sendMessage();
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(36)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed('/search_products');
                                          },
                                          child: SvgPicture.asset(
                                            "assets/icons/search_icon.svg",
                                            width:
                                                getProportionateScreenWidth(25),
                                            height:
                                                getProportionateScreenWidth(25),
                                            color: AppColors.greenTextColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              getProportionateScreenWidth(15),
                                        ),
                                        GestureDetector(
                                          onTap: AppConstants.goToMessages,
                                          child: SvgPicture.asset(
                                            "assets/icons/messages_icon.svg",
                                            width:
                                                getProportionateScreenWidth(20),
                                            height:
                                                getProportionateScreenWidth(23),
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
                                            Get.toNamed('/favorites');
                                          },
                                          child: SvgPicture.asset(
                                            "assets/icons/favourite_icon.svg",
                                            width:
                                                getProportionateScreenWidth(25),
                                            height:
                                                getProportionateScreenWidth(25),
                                            color: AppColors.greenTextColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              getProportionateScreenWidth(15),
                                        ),
                                        GestureDetector(
                                          onTap: AppConstants.goToNotification,
                                          child: SvgPicture.asset(
                                            "assets/icons/notifications_icon.svg",
                                            width:
                                                getProportionateScreenWidth(25),
                                            height:
                                                getProportionateScreenWidth(25),
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
        })),
      ),
    );
  }
}
