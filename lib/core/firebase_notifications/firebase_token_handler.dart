import 'package:firebase_messaging/firebase_messaging.dart';

import 'fcm_repo.dart';

var fcmTokenRepo = FCMTokenRepo();
Future<String> getToken() async {
    print('value:: start ::: ::: ');
  await FirebaseMessaging.instance.getToken().then((value) {
    print('value::::: ::::: ===== $value');
    fcmTokenRepo.postFCMToken(value.toString());
    return value.toString();
  });
  return '';
}

Future<String> deleteToken() async {
  await FirebaseMessaging.instance.deleteToken();

  return '';
}

Future<String> getTokenOnRefresh() async {
  print('start sending fcmToken ================================');
  String token = '';
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    // print(object)
    fcmTokenRepo.postFCMToken(fcmToken);
    token = fcmToken;
  }).onError((err) {
    throw Exception('');
  });

  return token;
}
