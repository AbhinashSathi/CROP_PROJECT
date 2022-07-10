import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notiPlugin =
      FlutterLocalNotificationsPlugin();

  static void initilize() {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_lancher"));

    _notiPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "easyapproach",
        "this is our channel",
        importance: Importance.max,
        priority: Priority.high,
      ));

      await _notiPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["route"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
