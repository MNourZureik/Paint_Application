import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:AEC_Mobile/core/app_colors.dart';
import 'package:AEC_Mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/firebase_notifications/firebase_token_handler.dart';
import '../../../core/secure_storage.dart';
import '/core/net/response/base_response.dart';
import '../../../app_config/default_settings.dart';
import '../../sign_in/model/response/user_model.dart';
import '../model/response/auth.dart';
import '../services/splash_service.dart';
import '../presentation/splash_state.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashController extends GetxController {
  final _service = SplashService();
  Rx<SplashState> pageState = SplashState.initial.obs;
  var isSignedIn = false.obs;
  static late Auth auth;
  static var noAuth = false.obs;
  late BaseResponse baseResponse;
  bool? verify;
  late String appVersion;
  bool isUptodate = true;

  @override
  void onReady() async {
    pageState.value = SplashState.loading;
    DefaultSetting.user = await User().readData();
    await Future.delayed(const Duration(milliseconds: 6000));
    await getToken();
    appVersion = await _getAppVersion();
    appData!.setString("version", appVersion);
    isUptodate = await checkVersion();
    if (!isUptodate) {
      forceUpdateDialog(
        context: Get.context!,
        currentVersion: appVersion,
        latestVersion: "1.1.0",
        onUpdate: () {
          Uri uri = Uri.parse("https://aecmobile.com");
          launchUrl(uri, mode: LaunchMode.externalApplication);
        },
      );
    } else {
      pageState.value = SplashState.initial;
    }
    update(['update_app']);
    await requestPermission();
    super.onReady();
  }

  checkAuth() async {
    var secureStorage = SecureStorage();
    var ver = await secureStorage.readValue('verify');
    var phone = await secureStorage.readValue('phone');
    var resend = await secureStorage.readValue('resend');
    print('ver new last :::: $ver, ${await secureStorage.readValue('verify')}');
    verify = ver != null;
    if (verify != null && verify != false) {
      Get.offAllNamed('/verify_account', arguments: [phone, resend == 'true']);
      noAuth(true);
    } else if (DefaultSetting.user.accessToken != null) {
      baseResponse = await _service.checkAuth(DefaultSetting.user.accessToken!);
      if (baseResponse.status == 200) {
        log("user_data : ${baseResponse.data}");
        auth = Auth.fromJson(baseResponse.data);
        DefaultSetting.user.userableType = auth.userableType;
        DefaultSetting.user.saveData();
        if (auth.isActive == 1) {
          if (auth.userableType != "observer") {
            isSignedIn(true);
            Get.offAllNamed('/main_app');
            noAuth(false);
          } else {
            Get.toNamed('/start');
            noAuth(true);
          }
        } else {
          Get.toNamed('/start');
          noAuth(true);
        }
      } else {
        Get.toNamed('/start');
        noAuth(true);
      }
    } else {
      Get.toNamed('/start');
      noAuth(true);
    }
  }

  requestPermission() async {
    await requestStoragePermission();
    await requestNotificationPermission();
  }

  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      // For Android 11+ (Scoped Storage)
      if (await Permission.manageExternalStorage.isGranted) {
        return true;
      }

      // Request Permission
      var status = await Permission.manageExternalStorage.request();

      if (status.isGranted) {
        return true; // Permission Granted
      } else if (status.isPermanentlyDenied) {
        // Redirect the user to the app settings
        await openAppSettings();
        return false;
      }

      return false; // Permission Denied
    }

    // For iOS or other platforms
    return true;
  }

  Future<bool> requestNotificationPermission() async {
    if (Platform.isAndroid || Platform.isIOS) {
      // Check if permission is already granted
      if (await Permission.notification.isGranted) {
        return true; // Permission is already granted
      }

      // Request notification permission
      var status = await Permission.notification.request();

      if (status.isGranted) {
        return true; // Permission Granted
      } else if (status.isPermanentlyDenied) {
        // Redirect the user to the app settings
        await openAppSettings();
        return false;
      }

      return false; // Permission Denied
    }

    // For platforms that don't require notification permissions
    return true;
  }

  Future<bool> checkVersion() async {
    baseResponse = await _service.checkVersion(appVersion);
    log("check version : ${baseResponse.status}");
    if (baseResponse.data) {
      log("version response data ali : ${baseResponse.data}");
      await checkAuth();
      return true;
    } else {
      return false;
    }
  }

  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    return appVersion;
  }

  void forceUpdateDialog({
    required BuildContext context,
    required String currentVersion,
    required String latestVersion,
    required VoidCallback onUpdate,
  }) {
    showDialog(
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async =>
                false, // Prevent user from dismissing the dialog
            child: AlertDialog(
              title: const Text(
                'Update Required',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left, // Align title to the left
              ),
              content: const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end, // Align all children to the left
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'A new version available',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left, // Align text to the left
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Please update to continue using the app',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.left, // Align text to the left
                  ),
                ],
              ),
              actionsAlignment:
                  MainAxisAlignment.start, // Align actions to the left
              actions: [
                ElevatedButton(
                  onPressed: onUpdate,
                  child: const Text(
                    'Update',
                    style: TextStyle(color: AppColors.greenTextColor),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
