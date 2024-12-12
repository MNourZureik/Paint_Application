import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/app_colors.dart';
import '/core/size_config.dart';

class ProductCard extends StatelessWidget {
  final double? width, height;
  final String? name, price;
  final String? imageUrl;
  final Function()? onTap,onFavourite;
  final bool? isFavourite;

  const ProductCard(
      {this.height,
      this.width,
      this.imageUrl,
      this.name,
      this.price,
      this.onTap,
        this.isFavourite=false,
        this.onFavourite
      })
      : super();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height! ,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                spreadRadius: .22,
                blurRadius: 5,
                offset: Offset(0, 1), // changes position of shadow
              ),
              BoxShadow(
                color: Colors.blue.withOpacity(.05),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 3.0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      width: width! * .75,
                      height: height! * .525,
                      child: Column(
                        children: [
                          Container(
                            width: width! * .7,
                            height: height! * .525,
                            child: Center(
                              child: imageUrl != null
                                  ? CachedNetworkImage(
                                imageUrl:
                                imageUrl!,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )

                                  : Image.asset("assets/images/product.png"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Align(
                      alignment: const Alignment(.75,0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(name!,
                        style: TextStyle(
                          fontFamily: "BahijPlain",
                          fontSize: 14.sp,
                          color: AppColors.greyTextColor
                        ),
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Visibility(
                      visible: isFavourite!=null,
                      child: GestureDetector(
                        onTap: onFavourite,
                        child: Align(
                          alignment: Alignment(-.9,0),
                          child: Icon(
                            (isFavourite!=null)?(isFavourite!?Icons.favorite:Icons.favorite_border):Icons.favorite_border,
                            color: AppColors.greenTextColor,
                            size: getProportionateScreenWidth(25),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
