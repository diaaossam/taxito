import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/features/user/main/presentation/cubit/main/main_cubit.dart';
import 'package:taxito/features/user/main/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:force_update_helper/force_update_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../config/helper/context_helper.dart';
import '../../../../../widgets/update_dialog.dart';
import '../../../../captain/settings/presentation/bloc/settings_bloc.dart';

class MainLayout extends StatefulWidget {
  final int? index;

  const MainLayout({super.key, this.index});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool isConnected = true;

  @override
  Widget build(BuildContext context) {
    final model = context.read<SettingsBloc>().settingsModel;
    return ForceUpdateWidget(
      navigatorKey: NavigationService.navigatorKey,
      allowCancel: false,
      showStoreListing: (storeUrl) async {
        if (await canLaunchUrl(storeUrl)) {
          await launchUrl(storeUrl, mode: LaunchMode.externalApplication);
        }
      },
      showForceUpdateAlert: (context, allowCancel) => showUpdateDialog(context),
      forceUpdateClient: ForceUpdateClient(
        fetchRequiredVersion: () => Future.value(
          Platform.isIOS
              ? model?.fetchRequiredIosVersion ?? ""
              : model?.fetchRequiredAndroidVersion ?? "",
        ),
        iosAppStoreId: "6754816246",
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl<MainCubit>()
                  ..changeCurrentBottomNavIndex(currentIndex: widget.index),
          ),
        ],
        child: BlocConsumer<MainCubit, MainState>(
          listener: (context, state) {},
          builder: (context, state) {
            final bloc = context.read<MainCubit>();
            return Scaffold(
              body: LazyIndexedStack(index: bloc.index, children: bloc.screens),
              bottomNavigationBar: const CustomBottomNavBar(),
            );
          },
        ),
      ),
    );
  }
}
