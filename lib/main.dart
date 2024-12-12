import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/app.dart';
import 'firebase_options.dart';

SharedPreferences? appData;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.subscribeToTopic("campaign-topic");
  await FlutterDownloader.initialize(debug: true);
  var fcmToken = await FirebaseMessaging.instance.getToken();
  print('fcm: $fcmToken');
  appData = await SharedPreferences.getInstance();
  runApp(const App());
}
