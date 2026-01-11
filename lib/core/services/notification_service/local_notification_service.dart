import 'dart:convert';
import 'dart:io';
import 'package:taxito/config/helper/context_helper.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../features/captain/delivery_main/presentation/pages/delivery_main_layout.dart';
import '../../../features/captain/driver_main/presentation/pages/driver_main_layout.dart';

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');
    _localNotificationService
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    DarwinInitializationSettings iosInitialization =
        const DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitialization,
    );
    if (Platform.isIOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
    await _localNotificationService.initialize(
      settings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  void _onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final payload = notificationResponse.payload;
    if (payload != null) {
      final data = jsonDecode(payload.toString());

      final context = NavigationService.navigatorKey.currentContext;
      if (data["type"] == "trip_request" && context != null) {
        String tripUUid = data['trip_uuid'];
        String tripId = data['trip_id'];
        context.navigateTo(
          DriverMainLayout(tripUuid: tripUUid, tripId: tripId),
        );
      }
      if (data["order_id"] != null) {
        num id = int.parse(data['order_id'] ?? '0');
        final context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          context.navigateToAndFinish(DeliveryMainLayout(id: id));
        }
      }
    }
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          "high_importance_channel",
          "High Importance Notifications",
          channelDescription: "channelDescription",
          playSound: true,
          priority: Priority.max,
          channelShowBadge: true,
          importance: Importance.max,
          enableVibration: true,
        );
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required Map<String, dynamic> payload,
  }) async {
    final payloadJson = jsonEncode(payload);
    final details = await _notificationDetails();
    await _localNotificationService.show(
      id,
      title,
      body,
      details,
      payload: payloadJson,
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
}
