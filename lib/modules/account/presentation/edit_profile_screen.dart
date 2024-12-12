import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/modules/account/model/response/citities_model.dart';
import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../core/waiting_widget.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_input_field.dart';
import '../../../widget/logo.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/edit_profile_controller.dart';
import 'edit_profile_state.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileController controller = Get.find();
  static const String routeName = '/EditProfileScreenRouteName';
  static const String pageIdentifier = 'EditProfileScreenIdentifier';

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Obx(
          () {
            if (controller.pageState.value == EditProfileState.loading) {
              return getWaitingWidget(pageIdentifier);
            } else if (controller.pageState.value == EditProfileState.error) {
              return Container();
            } else {
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
                            SplashController.auth.phoneNumber!,
                            style: TextStyle(
                              color: AppColors.greenTextColor,
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
                            SplashController.auth.fstName!,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "BahijBold",
                              color: AppColors.greenTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Center(
                          child: Text(
                            SplashController.auth.code!,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "BahijBold",
                              color: AppColors.greenTextColor,
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
                              controller.firstNameController.text = val;
                            },
                            hintText: controller.firstNameController.text,
                            maxLength: 10,
                            textInputType: TextInputType.name,
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "BahijBold",
                              color: AppColors.grey1,
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
                              controller.lastNameController.text = val;
                            },
                            isGrey: true,
                            hintText: controller.lastNameController.text,
                            hintStyle: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "BahijBold",
                              color: AppColors.grey1,
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
                        DefaultSetting.user.userableType == "member"
                            ? Column(
                                children: [
                                  UnconstrainedBox(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(36)),
                                        color: AppColors
                                            .upperNavBarBackgroundColor,
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
                                                : controller.applyFilter(
                                                    city, text);
                                          },
                                          // searchFieldProps: TextFieldProps(
                                          //     cursorColor:
                                          //         AppColors.greenTextColor,
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
                                            return controller.cities.cities;
                                          },
                                          onChanged: (c) {
                                            controller.changeSelectedCity(c!);
                                          },
                                          // showSelectedItems: false,
                                          // dropdownSearchDecoration:
                                          //     InputDecoration.collapsed(
                                          //   hintText: controller
                                          //       .selectedCityController.text,
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
                                    height: getProportionateScreenHeight(25),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        Visibility(
                          visible:
                              DefaultSetting.user.userableType != 'distributor',
                          child: Center(
                            child: CustomButton(
                              width: 0.4.sw,
                              height: getProportionateScreenHeight(56),
                              text: "save".tr,
                              backgroundColor: AppColors.green,
                              onTap: () async {
                                await controller.editProfile();
                              },
                              textStyle: TextStyle(
                                color: AppColors.greenTextColor,
                                fontSize: 20.sp,
                                fontFamily: "BahijBold",
                              ),
                            ),
                          ),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(36)),
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Logo(
                                        width: .9.sw,
                                        height:
                                            getProportionateScreenHeight(200),
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
                                              onTap: () {},
                                              child: SvgPicture.asset(
                                                "assets/icons/search_icon.svg",
                                                width:
                                                    getProportionateScreenWidth(
                                                        25),
                                                height:
                                                    getProportionateScreenWidth(
                                                        25),
                                                color: AppColors.greenTextColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      15),
                                            ),
                                            GestureDetector(
                                              onTap: AppConstants.goToMessages,
                                              child: SvgPicture.asset(
                                                "assets/icons/messages_icon.svg",
                                                width:
                                                    getProportionateScreenWidth(
                                                        20),
                                                height:
                                                    getProportionateScreenWidth(
                                                        23),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.toNamed('favorites');
                                              },
                                              child: SvgPicture.asset(
                                                "assets/icons/favourite_icon.svg",
                                                width:
                                                    getProportionateScreenWidth(
                                                        25),
                                                height:
                                                    getProportionateScreenWidth(
                                                        25),
                                                color: AppColors.greenTextColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      15),
                                            ),
                                            GestureDetector(
                                              onTap:
                                                  AppConstants.goToNotification,
                                              child: SvgPicture.asset(
                                                "assets/icons/notifications_icon.svg",
                                                width:
                                                    getProportionateScreenWidth(
                                                        25),
                                                height:
                                                    getProportionateScreenWidth(
                                                        25),
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
          },
        ),
      ),
    );
  }
}
