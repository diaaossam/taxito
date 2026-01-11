import 'dart:io';

import 'package:taxito/features/captain/delivery_main/presentation/cubit/delivery_main/delivery_main_cubit.dart';
import 'package:taxito/features/captain/delivery_order/presentation/cubit/delivery_actions/delivery_actions_cubit.dart';
import 'package:taxito/features/captain/delivery_order/presentation/cubit/delivery_order_cubit.dart';
import 'package:taxito/features/captain/settings/presentation/pages/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:force_update_helper/force_update_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/bloc/socket/socket_cubit.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../config/helper/context_helper.dart';
import '../../../../../widgets/update_dialog.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../widgets/driver_main_layout/animated_bottom_bar.dart';
import 'delivery_home.dart';
import 'delivery_order_screen.dart';

class DeliveryMainLayout extends StatefulWidget {
  final num? id;

  const DeliveryMainLayout({super.key, this.id});

  @override
  State<DeliveryMainLayout> createState() => _DeliveryMainLayoutState();
}

class _DeliveryMainLayoutState extends State<DeliveryMainLayout> {
  @override
  void initState() {
    context.read<SocketCubit>().initSocketConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<SettingsBloc>().settingsModel;
    return ForceUpdateWidget(
      navigatorKey: NavigationService.navigatorKey,
      allowCancel: false,
      showStoreListing: (storeUrl) async {
        if (await canLaunchUrl(storeUrl)) {
          await launchUrl(
            storeUrl,
            mode: LaunchMode.externalApplication,
          );
        }
      },
      showForceUpdateAlert: (context, allowCancel) => showUpdateDialog(context),
      forceUpdateClient: ForceUpdateClient(
          fetchRequiredVersion: () => Future.value(Platform.isIOS
              ? model?.fetchRequiredIosVersion ?? ""
              : model?.fetchRequiredAndroidVersion ?? ""),
          iosAppStoreId: "6754820055"),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<DeliveryMainCubit>()),
          BlocProvider(create: (context) => sl<DeliveryOrderCubit>()),
          BlocProvider(create: (context) => sl<DeliveryActionsCubit>()),
        ],
        child: BlocBuilder<DeliveryMainCubit, DeliveryMainState>(
          builder: (context, state) {
            return Scaffold(
              body: [
                DeliveryHome(id: widget.id),
                const DeliveryOrderScreen(),
                const SettingsScreen(),
              ][context.read<DeliveryMainCubit>().currentIndex],
              bottomNavigationBar: const AnimatedBottomBar(),
            );
          },
        ),
      ),
    );
  }
}
