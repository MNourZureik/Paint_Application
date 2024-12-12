import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '/app_config/default_settings.dart';
import '/modules/product_details/presentation/product_details_state.dart';
import '/modules/product_details/presentation/product_files_state.dart';
import '/widget/size_component.dart';
import 'package:photo_view/photo_view.dart';
import '../../../core/constans.dart';
import '../controllers/product_details_controller.dart';
import '../../../core/app_colors.dart';
import '../../../core/size_config.dart';
import '../../../widget/logo.dart';
import '../../../widget/product_card.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsController controller = Get.find();
  var imageUrl = "";

  ProductDetailsScreen({super.key});

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
        Obx(() {
          if (controller.pageState.value == ProductDetailsState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(90),
                ),
                Center(
                    child: Container(
                  decoration: BoxDecoration(color: AppColors.white, boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.08),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ]),
                  width: MediaQuery.of(context).size.width * .89,
                  height: MediaQuery.of(context).size.height * .3,
                  child: CarouselWithIndicatorDemo(
                      controller.productDetails.image),
                )),

                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Center(
                  child: SizedBox(
                    height: getProportionateScreenHeight(75),
                    width: .6.sw,
                    child: ListView.builder(
                        itemCount: controller
                            .productDetails.availableSizesAndPrices.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizeComponent(
                                height: getProportionateScreenHeight(40),
                                color: AppColors.greenTextColor,
                                textColor: AppColors.white,
                                size: controller.productDetails
                                    .availableSizesAndPrices[index].size,
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(15),
                              ),
                            ],
                          );
                        }),
                  ),
                ),

                Container(
                  height: getProportionateScreenHeight(50),
                  width: 1.sw,
                  decoration: BoxDecoration(color: AppColors.white, boxShadow: [
                    BoxShadow(
                        color: AppColors.black.withOpacity(.25),
                        blurRadius: .5,
                        spreadRadius: .5,
                        offset: const Offset(0, 2)),
                  ]),
                  child: Center(
                    child: SizedBox(
                      width: .9.sw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.productDetails.name,
                            style: TextStyle(
                              fontFamily: "BahijPlain",
                              fontSize: 14.sp,
                              color: AppColors.greenTextColor,
                            ),
                          ),
                          Visibility(
                              visible: DefaultSetting.user.accessToken != null,
                              child: Obx(() {
                                return GestureDetector(
                                  onTap: () async {
                                    await controller.updateFavorite(
                                        controller.productDetails.id,
                                        controller.isFavorite);
                                  },
                                  child: Align(
                                    alignment: const Alignment(-.9, 0),
                                    child: Icon(
                                      controller.isFavorite.value
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: AppColors.greenTextColor,
                                      size: getProportionateScreenWidth(25),
                                    ),
                                  ),
                                );
                              })),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(25),
                ),
                //Product Description
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: .9.sw,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: Text(
                                  "product_description".tr,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "BahijBold",
                                    fontSize: 18.sp,
                                    color: AppColors.green,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/product_files",
                                      arguments: controller.productDetails);
                                },
                                child: Text(
                                  "download_brochures".tr,
                                  style: TextStyle(
                                    fontFamily: "BahijPlain",
                                    fontSize: 16.sp,
                                    color: AppColors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Center(
                        child: SizedBox(
                          width: .9.sw,
                          child: Text(
                            controller.productDetails.description,
                            style: TextStyle(
                              fontFamily: "BahijPlain",
                              fontSize: 16.sp,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Visibility(
                  visible: controller.productDetails.relatedProducts.isNotEmpty,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            width: .95.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Text(
                                    "you_might_like".tr,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "BahijBold",
                                      fontSize: 16.sp,
                                      color: AppColors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                            child: ListView.builder(
                                itemCount: controller
                                    .productDetails.relatedProducts.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  var added = false.obs;
                                  if (controller.productDetails
                                          .relatedProducts[index].isFavorite !=
                                      null) {
                                    added.value = controller
                                            .productDetails
                                            .relatedProducts[index]
                                            .isFavorite ??
                                        false;
                                  } else {
                                    added.value = false;
                                  }
                                  return GetBuilder<ProductDetailsController>(
                                      builder: (_) {
                                    return Row(
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .4,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: ProductCard(
                                                onTap: () {
                                                  controller.refreshData(
                                                      controller
                                                          .productDetails
                                                          .relatedProducts[
                                                              index]
                                                          .id);
                                                },
                                                width:
                                                    getProportionateScreenWidth(
                                                        175),
                                                height:
                                                    getProportionateScreenHeight(
                                                        250),
                                                name: controller
                                                    .productDetails
                                                    .relatedProducts[index]
                                                    .name,
                                                imageUrl: controller
                                                    .productDetails
                                                    .relatedProducts[index]
                                                    .image[0],
                                                isFavourite: added.value,
                                                onFavourite: () async {
                                                  await controller
                                                      .updateFavorite(
                                                          controller
                                                              .productDetails
                                                              .relatedProducts[
                                                                  index]
                                                              .id,
                                                          added);
                                                })),
                                        SizedBox(
                                          width:
                                              getProportionateScreenWidth(15),
                                        ),
                                      ],
                                    );
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(30),
                )
              ],
            );
          }
        }),
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

class CarouselWithIndicatorDemo extends StatefulWidget {
  List<String> imageSlider;

  CarouselWithIndicatorDemo(this.imageSlider, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState(imageSlider);
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  //final CarouselController _controller = CarouselController();
  List<String> imageSlider;

  // List<Ad>? ads;

  _CarouselWithIndicatorState(this.imageSlider);

  @override
  Widget build(BuildContext context) {
    final List<Widget> sliders = imageSlider
        .map((item) => GestureDetector(
              onTap: () {
                showMyDialog(
                    CachedNetworkImage(
                      imageUrl: item,
                      fit: BoxFit.fill,
                      imageBuilder: (context, imageProvider) => PhotoView(
                        imageProvider: imageProvider,
                      ),
                    ),
                    context);
              },
              child: Container(
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: CachedNetworkImage(
                          imageUrl: item,
                          width: .85.sw,
                          height: .3.sh,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
    return Column(children: [
      Expanded(
        child: CarouselSlider(
          items: sliders,
          // carouselController: _controller,
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height * .5,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageSlider.asMap().entries.map((entry) {
          return GestureDetector(
              onTap: () {},
              // _controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key ? Colors.black : Colors.grey,
                ),
              ));
        }).toList(),
      ),
    ]);
  }
}

Future<void> showMyDialog(widget, context) async {
  return showGeneralDialog<void>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false, // user must tap button!
    pageBuilder: (_, __, ___) {
      return SafeArea(
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Align(
                alignment: const Alignment(.9, -.9),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Icon(Icons.close_rounded),
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  child: SizedBox(
                    width: 1.sw,
                    height: .5.sh,
                    child: widget,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
