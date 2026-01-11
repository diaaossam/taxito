import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/core/services/network/app_interceptors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  Dio get dio => Dio();

  AndroidOptions get _androidOptions => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  IOSOptions get _iosOptions => const IOSOptions(
        accessibility: KeychainAccessibility.unlocked_this_device,
      );

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  Connectivity get connectivity => Connectivity();

  AppInterceptors get app => AppInterceptors(tokenRepository: sl());

  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  FirebaseAnalytics get firebaseAnalytics => FirebaseAnalytics.instance;

  FlutterSecureStorage get flutterSecureStorage =>
      FlutterSecureStorage(aOptions: _androidOptions, iOptions: _iosOptions);

  ImagePicker get imagePicker => ImagePicker();
}
