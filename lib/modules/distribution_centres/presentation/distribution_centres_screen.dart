import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/modules/distribution_centres/presentation/distribution_centres_state.dart';
import '../../../core/app_colors.dart';
import '../../../core/constans.dart';
import '../../../core/size_config.dart';
import '../../../widget/centre_card.dart';
import '../../../widget/logo.dart';
import '../controllers/distribution_centres_controller.dart';

class DistributionCentresScreen extends StatelessWidget {
  DistributionCentresController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SizeConfig().init(context);
    return Scaffold(
        body: SafeArea(
            child: Stack(
              children: [
                Obx((){
                  if(controller.pageState.value==DistributionCentresState.loading){
                    return const Center(child: CircularProgressIndicator(),);
                  }else{
                    if(controller.noDistributors.value){
                      return Center(child: Text("empty_centres".tr,style: TextStyle(
                          fontFamily: "BahijBold",
                          fontSize: 30.sp,
                          color: AppColors.greenTextColor
                      ),),);
                    }else{
                      return ListView(
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(100),
                          ),
                          Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height*.75 ,
                              width: .9.sw,
                              child: ListView.builder(
                                  itemCount: controller.distributors.distributors!.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                            decoration: const BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(10)),
                                            ),
                                            child: CentreCard(
                                              width: .9.sw,
                                              height: getProportionateScreenHeight(150),
                                              name: '${controller.distributors.distributors![index].firstName} ${controller.distributors.distributors![index].lastName}',
                                              address: controller.distributors.distributors![index].address,
                                              phoneNumber: controller.distributors.distributors![index].phone,
                                            )),
                                        SizedBox(
                                          height: getProportionateScreenHeight(15),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          ),

                        ],
                      );
                    }
                  }
                }),

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
                                          onTap: () {
                                            Get.toNamed('/search_products');
                                          },
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
            )));
  }
}
