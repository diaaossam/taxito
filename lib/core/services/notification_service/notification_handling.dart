import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'local_notification_service.dart';

Future<void> showNotification(RemoteMessage event) async {
  if (event.notification != null) {
    if (event.notification!.title != null &&
        event.notification!.title!.isNotEmpty) {

      LocalNotificationService().showNotification(
        id: Random().nextInt(200000),
        title: event.notification?.title ?? "",
        body: event.notification?.body ?? "",
        payload: event.data,
      );
    }
  }
}
