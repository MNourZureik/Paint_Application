import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_handler.dart';

void initializeFirebase() async {
  // Firebase Cloud Messaging setup
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Local notifications setup
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('mipmap/ic_launcher');
  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,);

  // Subscribe to FCM topic (if needed)

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    showNotification(message);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await showNotification(message);
}
