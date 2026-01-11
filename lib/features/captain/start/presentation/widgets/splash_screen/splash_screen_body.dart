import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/features/captain/settings/presentation/bloc/settings_bloc.dart';
import 'package:taxito/features/captain/start/presentation/cubit/start/start_cubit.dart';

import '../../../../../../config/helper/context_helper.dart';
import '../../../../driver_main/presentation/pages/driver_main_layout.dart';
import '../../cubit/start/start_state.dart';

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody> {
  @override
  void initState() {
    BlocProvider.of<StartCubit>(context).initApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return BlocConsumer<StartCubit, StartState>(
          listener: (context, state) {
            if (state is InitAppSuccess) {
              init(widget: state.widget, context: context);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: AppImage.asset(
                    Assets.images.logoCirclure.path,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void init({required Widget widget, required BuildContext context}) async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data.isNotEmpty) {
        final context = NavigationService.navigatorKey.currentContext;
        if (initialMessage.data["type"] == "trip_request" && context != null) {
          String tripUUid = initialMessage.data['trip_uuid'];
          String tripId = initialMessage.data['trip_id'];
          context.navigateTo(
            DriverMainLayout(tripUuid: tripUUid, tripId: tripId),
          );
        }
      }
    } else {
      context.navigateToAndFinish(widget);
    }
  }
}
