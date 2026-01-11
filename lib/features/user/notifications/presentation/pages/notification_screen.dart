import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aslol/config/dependencies/injectable_dependencies.dart';
import 'package:aslol/core/utils/app_constant.dart';
import 'package:aslol/features/notifications/presentation/cubit/notifications_cubit.dart';

import 'notification_body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationsCubit>(),
      child: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          if (state is GetAllNotificationsFailure) {
            AppConstant.showCustomSnakeBar(context, state.errorMsg, false);
          } else if (state is GetAllNotificationsSuccess) {
            context.read<NotificationsCubit>().markAllAsRead();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: context.localizations.notification,
            ),
            body: const NotificationBody(),
          );
        },
      ),
    );
  }
}
