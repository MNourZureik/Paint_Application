import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/app_colors.dart';
import '/core/size_config.dart';
import 'package:shimmer/shimmer.dart';

class GiftCard extends StatelessWidget {
  final double? width, height;
  final String? imageUrl,date,name;

  GiftCard(
      {this.height,
        this.width,
        this.imageUrl,
        this.date,
        this.name
      })
      : super();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
        child: Column(
          children: [
            SizedBox(
                width: width!*.9,
                height: height!*.7,
                child: imageUrl != null
                    ? CachedNetworkImage(
                  imageUrl:
                  imageUrl!,
                  placeholder: (context, url) =>
                      ProfileImageShimmerEffect(
                        width: width!,
                        height: height!,
                      ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                ):Container()

            ),
            Center(
              child: Column(
                children: [
                  Text(
                    name!,
                    style:TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "BahijBold",
                        color: AppColors.greenTextColor
                    ) ,
                  ),
                  Text(
                    date!,
                    style:TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "BahijBold",
                      color: AppColors.greenTextColor
                    ) ,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ProfileImageShimmerEffect extends StatelessWidget {
  final double width, height;

  ProfileImageShimmerEffect({
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.white,
      highlightColor: AppColors.grey1,
      enabled: true,
      period: const Duration(seconds:2),
      child: Container(
        width: width,
        height: height,
        decoration:const BoxDecoration(
          color: AppColors.white,
        ),
      ),
    );
  }
}
