import 'dart:developer';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '/core/size_config.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/app_colors.dart';

class CentreCard extends StatelessWidget {
  double? width, height;
  String? name, address, phoneNumber;

  CentreCard(
      {Key? key, this.width, this.height, this.name, this.address, this.phoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openDialog(context);
      },
      child: Container(
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
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(name!,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "BahijBold",
                    color: AppColors.blue
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(address!,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "BahijPlain",
                    color: AppColors.blue
                ),
                maxLines: 2,
              ),
              SizedBox(
                height: getProportionateScreenHeight(5),
              ),
              Text(phoneNumber!,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "BahijPlain",
                    color: AppColors.blue
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  _openDialog(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) {
      return SizedBox(
        height: 150,
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: GestureDetector(
                onTap: () async{
                  await Clipboard.setData(ClipboardData(text: phoneNumber ?? ''));
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "تم نسخ الرقم إلى الحافظة",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                },
                child: ListTile(
                  leading: const Icon(Icons.copy),
                  title: Text("copy_number".tr,style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: "BahijBold",
                      color: AppColors.blue,
                  ),),
                ),
              ),
            ),
            const Divider(),
            SizedBox(
              height: 50,
              child: GestureDetector(
                onTap: () async{
                  launch('tel:$phoneNumber');
                },
                child: ListTile(
                  leading: const Icon(Icons.call),
                  title: Text("make_call".tr,style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: "BahijBold",
                    color: AppColors.blue,
                  ),),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
  static launch(String url) async {
    if(Platform.isIOS){
      // todo: need config and test IOS URL launcher
    }else if(Platform.isAndroid){
      try {
        await launchUrl(
            Uri.parse(url),mode :LaunchMode.platformDefault
        );
        return true;
      } catch (e) {
        log(e.toString());
        return false;
      }
    }
    else{

    }
  }

}
