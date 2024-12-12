import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/core/waiting_widget.dart';
import '/modules/notifications/presentation/notifications_state.dart';
import '../../../core/app_colors.dart';
import '../../../core/size_config.dart';
import '../controllers/notifications_controller.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsController controller = Get.find();
  static const pageIdentifier='NotificationsScreen';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
            child:Obx((){
              if(controller.pageState.value==NotificationsState.loading){
                return getWaitingWidget(pageIdentifier);
              }else{
                if(controller.noNotifications.value){
                  return Center(child: Text("empty_notifications".tr,style: TextStyle(
                      fontFamily: "BahijBold",
                      fontSize: 30.sp,
                      color: AppColors.greenTextColor
                  ),),);                }else{
                  return Stack(
                    children: [
                      ListView(
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(50),
                          ),
                          Center(
                            child: SizedBox(
                              width: .9.sw,
                              child: Text(
                                "notifications".tr,
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
                          Column(

                            children:controller.notifications.notifications.map((e) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.body,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontFamily: "BahijPlain",
                                      color: AppColors.greenTextColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(15),
                                  ),
                                  Text(
                                    e.date.toString().substring(0,11),
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontFamily: "BahijPlain",
                                      color: AppColors.greenTextColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(15),
                                  ),
                                  Container(
                                    height: 1,
                                    width: .9.sw,
                                    color: AppColors.greenTextColor,
                                  ),
                                ],
                              );
                            } ).toList(),
                          ),

                        ],
                      ),
                    ],
                  );
                }
              }
            })
        ));
  }
}
