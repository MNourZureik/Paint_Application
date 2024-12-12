import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FireBaseNotifications extends GetxController {
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late NotificationDetails notificationDetails;


  @override
  void onInit() {
    initNotifications();
    super.onInit();
  }

  

  initNotifications() async {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );
    notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        icon: 'app_logo',
        playSound: true,
      ),
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Map<String, dynamic> data = message.data;
      if (!kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          data.hashCode,
          "",
          data["body"],
          notificationDetails,
        );
      }
    });


    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
      );
    }

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }




Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );
  }
  print('aaaaaaaaaaaaaaaaaa');
  print(message.data);
  print('aaaaaaaaaaaaaaaaaa');
  Map<String, dynamic> data = message.data;
  if (!kIsWeb) {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    flutterLocalNotificationsPlugin.show(
      data.hashCode,
      "",
      data['body'],
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'app_logo',
          playSound: true,
        ),
      ),
    );
  }
}


}

