import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/dependencies/injectable_dependencies.dart';

class CommonCaching {
  CommonCaching._();

  static final SharedPreferences _pref = sl<SharedPreferences>();
}
