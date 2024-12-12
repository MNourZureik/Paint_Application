// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import 'splash_state.dart';

class SplashScreen extends StatelessWidget {
  SplashController controller = Get.find();

  SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        id: 'update_app',
        builder: (_) {
          return Obx(() {
            if (controller.pageState.value == SplashState.loading) {
              return Container(
                width: MediaQuery.of(context).size.height * .70,
                height: MediaQuery.of(context).size.height * .70,
                color: Colors.white,
                child: Image.asset(
                  'assets/images/splashscreen.png',
                  fit: BoxFit.fill,
                ),
              );
            } else {
              return Container();
            }
          });
        });
  }

  }
