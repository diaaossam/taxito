import 'package:taxito/core/extensions/navigation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../config/helper/context_helper.dart';
import '../../../features/captain/delivery_main/presentation/pages/delivery_main_layout.dart';
import '../../../features/captain/driver_main/presentation/pages/driver_main_layout.dart';
import 'local_notification_service.dart';
import 'notification_handling.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class NotificationService {
  Future<String?> getDeviceToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  Future<void> initNotification() async {
    await LocalNotificationService().initializeNotification();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((event) async {
      await showNotification(event);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.isNotEmpty) {
        final context = NavigationService.navigatorKey.currentContext;
        if (message.data["type"] == "trip_request" && context != null) {
          String tripUUid = message.data['trip_uuid'];
          String tripId = message.data['trip_id'];
          context.navigateTo(DriverMainLayout(
            tripUuid: tripUUid,
            tripId: tripId,
          ));
        }
        if(message.data["order_id"] != null ){
          num id = int.parse(message.data['order_id'] ?? '0');
          final context = NavigationService.navigatorKey.currentContext;
          if (context != null) {
            context.navigateToAndFinish(DeliveryMainLayout(id: id));
          }
        }

      }
    });
  }
}
