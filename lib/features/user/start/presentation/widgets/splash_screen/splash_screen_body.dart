import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aslol/core/services/deep_link/deep_link.dart';
import 'package:aslol/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:aslol/features/start/presentation/cubit/start/start_cubit.dart';

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
                    Assets.images.logo.path,
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
        /// Handle Killed Background Notification
      }
    } else {
      await DynamicLinkHandler.instance.initialize(callback: (value) {
        Future.delayed(
          const Duration(seconds: 2),
          () => context.navigateToAndFinish(widget),
        );
      });
    }
  }
}
