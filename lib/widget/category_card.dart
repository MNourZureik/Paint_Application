import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/app_colors.dart';
import '/core/size_config.dart';

class CategoryCard extends StatelessWidget {
  final double? width, height;
  final String? name, price;
  final String? imageUrl;
  final Function()? onTap;

  const CategoryCard(
      {this.height,
        this.width,
        this.imageUrl,
        this.name,
        this.price,
        this.onTap,
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
            padding: EdgeInsets.fromLTRB(0, 9.0, 0, 0),
            child: Column(
              children: [
                Container(
                  width: width,
                  height: height! * .7,
                  child: Column(
                    children: [
                      Container(
                        width: width!,
                        height: height! * .7,
                        child: Center(
                          child: imageUrl != null
                              ? CachedNetworkImage(
                            imageUrl:
                            imageUrl!,
                            fit: BoxFit.cover,
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(name!,
                      style: TextStyle(
                          fontFamily: "BahijPlain",
                          fontSize: 16.sp,
                          color: AppColors.greyTextColor
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
