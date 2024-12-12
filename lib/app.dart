import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_config/default_settings.dart';
import 'core/firebase_notifications/firebase_messaging_handler.dart';
import 'core/firebase_notifications/firebase_token_handler.dart';
import 'core/navigation/app_routers.dart';
import 'lang/localization_service.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
@override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    // getTokenOnRefresh();
    // await getToken();
    initializeFirebase();
  });
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "AEC Mobile",
          debugShowCheckedModeBanner: false,
          textDirection: DefaultSetting.appDirection,
          locale: DefaultSetting.locale,
          fallbackLocale: LocalizationService.fallbackLocale,
          translations: LocalizationService(),
          initialRoute: AppRouters.initRoute,
          getPages: AppRouters.PAGES,
          defaultTransition: Transition.leftToRightWithFade,
        );
      },
    );
  }
}
