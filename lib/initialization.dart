import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/config/environment/environment_helper.dart';
import 'package:taxito/config/helper/firebase/firebase_helper.dart';
import 'package:taxito/core/bloc/bloc_observer.dart';
import 'package:taxito/core/services/notification_service/notification_service.dart';
import 'package:taxito/core/utils/api_config.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: Environment.fileName);
  configureDependencies();
  await ApiConfig().init();
  await FirebaseHelper().initFirebaseServices();
  await NotificationService().initNotification();
}
