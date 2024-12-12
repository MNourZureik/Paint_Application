import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/core/waiting_widget.dart';
import '/modules/administration_messages/presentation/administration_messages_state.dart';
import '../controllers/administration_messages_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/app_colors.dart';
import '../../../core/size_config.dart';

class AdministrationMessagesScreen extends StatelessWidget {
  AdministrationMessagesController controller = Get.find();
  static const String pageIdentifier = 'AdministrationMessagesScreen';

  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.greenTextColor,
          onPressed: () {
            Get.toNamed('/send_message');
          },
          child: Center(
            child: Icon(
              Icons.add,
              color: AppColors.white,
              size: 35,
            ),
          ),
        ),
        body: SafeArea(
            child: Stack(
          children: [
            (DefaultSetting.user.userableType == 'member')
                ? Obx(() {
                    if (controller.pageState.value ==
                        AdministrationMessagesState.loading) {
                      return getWaitingWidget(
                          AdministrationMessagesScreen.pageIdentifier);
                    } else if (DefaultSetting.user.accessToken == null) {
                      return Center(
                        child: Text(
                          "لا يوجد رسائل",
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
                            height: getProportionateScreenHeight(50),
                          ),
                          Center(
                            child: SizedBox(
                              width: .9.sw,
                              child: Text(
                                "messages".tr,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: "BahijBold",
                                  color: AppColors.greenTextColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Obx(() {
                            if (controller.noMessages.value) {
                              return Center(
                                child: Text(
                                  "empty_messages".tr,
                                  style: TextStyle(
                                      fontFamily: "BahijBold",
                                      fontSize: 30.sp,
                                      color: AppColors.greenTextColor),
                                ),
                              );
                            } else {
                              return Center(
                                child: SizedBox(
                                  height: .75.sh,
                                  width: .9.sw,
                                  child: ListView.builder(
                                      itemCount:
                                          controller.messages.messages.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                controller.messages
                                                    .messages[index].title,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontFamily: "bahijBold",
                                                  color:
                                                      AppColors.greenTextColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                controller.messages
                                                    .messages[index].text,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontFamily: "BahijPlain",
                                                  color:
                                                      AppColors.greenTextColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                controller.messages
                                                    .messages[index].date
                                                    .toString()
                                                    .substring(0, 10),
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontFamily: "BahijPlain",
                                                  color:
                                                      AppColors.greenTextColor,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      15),
                                            ),
                                            Container(
                                              height: 1,
                                              width: .9.sw,
                                              color: AppColors.greenTextColor,
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      15),
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              );
                            }
                          })
                        ],
                      );
                    }
                  })
                : Obx(() {
                    if (controller.pageState.value ==
                        AdministrationMessagesState.loading) {
                      return getWaitingWidget(
                          AdministrationMessagesScreen.pageIdentifier);
                    } else if (DefaultSetting.user.accessToken == null) {
                      return Center(
                        child: Text(
                          "لا يوجد رسائل",
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
                            height: getProportionateScreenHeight(50),
                          ),
                          Center(
                            child: SizedBox(
                              width: .9.sw,
                              child: Text(
                                "messages".tr,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontFamily: "BahijBold",
                                  color: AppColors.greenTextColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          SizedBox(
                            width: .9.sw,
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: "رسائل الإدارة",
                                      activeColor: AppColors.greenTextColor,
                                      groupValue:
                                          controller.showMessagesType.value,
                                      onChanged: (String? val) {
                                        controller.showMessagesType(val);
                                      },
                                    ),
                                    Text(
                                      "رسائل الإدارة",
                                      style: TextStyle(
                                          color: AppColors.greenTextColor,
                                          fontSize: 16.sp,
                                          fontFamily: "bahijBold"),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(25),
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: "رسائل الأعضاء",
                                      activeColor: AppColors.greenTextColor,
                                      groupValue:
                                          controller.showMessagesType.value,
                                      onChanged: (String? val) {
                                        controller.showMessagesType(val);
                                      },
                                    ),
                                    Text(
                                      "رسائل الأعضاء",
                                      style: TextStyle(
                                          color: AppColors.greenTextColor,
                                          fontSize: 16.sp,
                                          fontFamily: "bahijBold"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25),
                          ),
                          Obx(() {
                            if (controller.noMessages.value) {
                              return Center(
                                child: Text(
                                  "empty_messages".tr,
                                  style: TextStyle(
                                      fontFamily: "BahijBold",
                                      fontSize: 30.sp,
                                      color: AppColors.greenTextColor),
                                ),
                              );
                            } else if (controller.showMessagesType.value ==
                                "رسائل الإدارة") {
                              if(controller.messages.messages.isEmpty){
                                return Center(
                                  child: Text(
                                    "empty_messages".tr,
                                    style: TextStyle(
                                        fontFamily: "BahijBold",
                                        fontSize: 25.sp,
                                        color: AppColors.greenTextColor),
                                  ),
                                );
                              }else{
                                return Center(
                                  child: SizedBox(
                                    height: .75.sh,
                                    width: .9.sw,
                                    child: ListView.builder(
                                        itemCount:
                                        controller.messages.messages.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  controller.messages
                                                      .messages[index].title,
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontFamily: "bahijBold",
                                                    color:
                                                    AppColors.greenTextColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                getProportionateScreenHeight(
                                                    10),
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  controller.messages
                                                      .messages[index].text,
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontFamily: "BahijPlain",
                                                    color:
                                                    AppColors.greenTextColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                getProportionateScreenHeight(
                                                    10),
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  controller.messages
                                                      .messages[index].date
                                                      .toString()
                                                      .substring(0, 10),
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontFamily: "BahijPlain",
                                                    color:
                                                    AppColors.greenTextColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                getProportionateScreenHeight(
                                                    15),
                                              ),
                                              Container(
                                                height: 1,
                                                width: .9.sw,
                                                color: AppColors.greenTextColor,
                                              ),
                                              SizedBox(
                                                height:
                                                getProportionateScreenHeight(
                                                    15),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                );
                              }

                            } else {
                              if(controller.userMessagesToDist.messages.isEmpty){
                                return Center(
                                  child: Text(
                                    "empty_messages".tr,
                                    style: TextStyle(
                                        fontFamily: "BahijBold",
                                        fontSize: 25.sp,
                                        color: AppColors.greenTextColor),
                                  ),
                                );
                              }else{
                                return Center(
                                  child: SizedBox(
                                    width: .9.sw,
                                    height: .75.sh,
                                    child: ListView.builder(
                                        itemCount: controller.userMessagesToDist.messages.length,
                                        scrollDirection: Axis.vertical,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  controller.userMessagesToDist
                                                      .messages[index].senderName,
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontFamily: "bahijBold",
                                                    color:
                                                    AppColors.greenTextColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                getProportionateScreenHeight(
                                                    10),
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  controller.userMessagesToDist
                                                      .messages[index].phoneNumber,
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontFamily: "bahijPlain",
                                                    color:
                                                    AppColors.greenTextColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                getProportionateScreenHeight(
                                                    10),
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  controller.userMessagesToDist
                                                      .messages[index].text,
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontFamily: "BahijPlain",
                                                    color:
                                                    AppColors.greenTextColor,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                getProportionateScreenHeight(
                                                    10),
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  controller.userMessagesToDist
                                                      .messages[index].date
                                                      .toString()
                                                      .substring(0, 10),
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    fontFamily: "BahijPlain",
                                                    color:
                                                    AppColors.greenTextColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              SizedBox(
                                                height:
                                                getProportionateScreenHeight(
                                                    15),
                                              ),
                                              Container(
                                                height: 1,
                                                width: .9.sw,
                                                color: AppColors.greenTextColor,
                                              ),
                                              SizedBox(
                                                height:
                                                getProportionateScreenHeight(
                                                    15),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                );
                              }
                            }
                          }),

                        ],
                      );
                    }
                  }),
          ],
        )));
  }
}
