import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

abstract class DeviceHelper {
  Future<String> get deviceToken;

  String get devicePlatform;
}

@Injectable(as: DeviceHelper)
class DeviceHelperImpl implements DeviceHelper {
  @override
  Future<String> get deviceToken async {
    try {
      String? token = await FirebaseMessaging.instance.getToken() ?? "";
      return token;
    } catch (error) {
      return "Fcm";
    }
  }

  @override
  String get devicePlatform => Platform.isAndroid ? "android" : "ios";
}
