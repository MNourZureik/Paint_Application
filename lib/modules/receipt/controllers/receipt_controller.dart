import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/app_colors.dart';
import '../../../core/net/app_urls.dart';
import '../../../core/net/http_client.dart';
import '../services/receipt_service.dart';
import '../presentation/receipt_state.dart';
import 'package:image/image.dart' as img;

class ReceiptController extends GetxController {
  final _service = ReceiptService();
  Rx<ReceiptState> pageState = ReceiptState.initial.obs;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late BuildContext context;
  uploadPicture(type) async {
    final ImagePicker picker = ImagePicker();
    XFile? image;
    // Pick an image
    if (type == 0) {
      image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
    } else {
      image =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    }
    if (image != null) {
      // TODO upload fix
      final path = image.path;
      final bytes = await File(path).readAsBytes();
      print(File(image.path).lengthSync());
      final image1 = Image.file(File(image.path));

      print(image1.height);
      _showMyDialog(image1, context);
      scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text(
          'يتم رفع فاتورتك',
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: "BahijPlain",
            color: AppColors.white,
          ),
        ),
        duration: const Duration(milliseconds: 1500),
      ));
      var url = "${APIUrls.BASE_URL}/api/uploadBill";
      var x = await _service.apiRepo.uploadImage(image, url);
      print(x.data);
      if (x.data['success'] == true) {
        scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(
            'تم رفع فاتورتك بنجاح',
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "BahijPlain",
              color: AppColors.white,
            ),
          ),
          duration: const Duration(milliseconds: 1500),
        ));
      } else {
        scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(
            "حدث خطأ اثناء رفع فاتورتك، حاول مجددا",
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: "BahijPlain",
              color: AppColors.white,
            ),
          ),
          duration: const Duration(milliseconds: 1500),
        ));
      }
    }
  }
}

Future<void> _showMyDialog(widget, context) async {
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
                    Get.back();
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
