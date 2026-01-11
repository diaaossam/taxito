import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName => ".env.development";

  static String get apiUrl => dotenv.env['API_BASE_URL'] ?? 'MY_FALLBACK';

  static String get xApiKey => dotenv.env['X_API'] ?? 'MY_FALLBACK';

  static String get appSecretIos =>
      dotenv.env['APP_SECRET_IOS'] ?? 'MY_FALLBACK';

  static String get socketUrl => dotenv.env['SOCKET_BASE_URL'] ?? 'MY_FALLBACK';

  static String get revenuecatAppleApiKey =>
      dotenv.env['PURCHASE_APPLE_API'] ?? 'MY_FALLBACK';

  static String get revenuecatGoogleApiKey =>
      dotenv.env['PURCHASE_GOOGLE_API'] ?? 'MY_FALLBACK';

  static String get googleApiKey => dotenv.env['MAP_API_KEY'] ?? 'MY_FALLBACK';
}
