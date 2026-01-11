import 'package:flutter/material.dart';
import 'package:taxito/initialization.dart';

import 'app.dart';

Future<void> main() async {
  await initializeApp();
  runApp(const MyApp());
}
