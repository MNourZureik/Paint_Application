import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> showNotification(RemoteMessage? message) async {
  if (message == null || message.notification == null) {
    log(message!.notification!.title.toString());
    log(message.notification!.body.toString());

    return;
  }
  // Display a local notification
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification!.title,
    message.notification!.body,
    platformChannelSpecifics,
  );
}





////////////////////////////////////////////////////////////////
// Future<void> sendTestNotification() async {
//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//   AndroidNotificationDetails(
//     'your_channel_id',
//     'your_channel_name',
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   const NotificationDetails platformChannelSpecifics =
//   NotificationDetails(android: androidPlatformChannelSpecifics);
//
//   await _flutterLocalNotificationsPlugin.show(
//     0, // notification id
//     'Test Notification',
//     'This is a test notification',
//     platformChannelSpecifics,
//   );
// }
//////////////////////////////////////////////////////////////
