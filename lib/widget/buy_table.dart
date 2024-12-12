import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/size_config.dart';

import '../core/app_colors.dart';

class BuyTable extends StatelessWidget {
  double? width, height;
  String? name, date, phoneNumber;
  String? imageUrl;

  BuyTable(
      {Key? key,
      this.width,
      this.height,
      this.name,
      this.date,
      this.phoneNumber,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: AppColors.green,
              spreadRadius: .22,
              blurRadius: .5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Row(
        children: [
          SizedBox(
            width: width!*.35,
            height: height!*.75,
            child: Center(
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                  : Container(),
            ),
          ),
          SizedBox(
            width: width!*.05,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  name!,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "BahijBold",
                      color: AppColors.blue),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  date!,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "BahijPlain",
                      color: AppColors.blue),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  phoneNumber!,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "BahijPlain",
                      color: AppColors.blue),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
