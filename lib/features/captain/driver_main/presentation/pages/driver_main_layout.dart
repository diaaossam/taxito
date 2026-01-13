import 'dart:io';
import 'package:taxito/features/captain/driver_trip/driver_trip_helper.dart';
import 'package:taxito/features/captain/settings/presentation/pages/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:force_update_helper/force_update_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../core/bloc/socket/socket_cubit.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../config/helper/context_helper.dart';
import '../../../../../core/data/models/trip_model.dart';
import '../../../../../widgets/update_dialog.dart';
import 'package:taxito/core/data/models/user_model.dart';
import '../../../driver_trip/presentation/pages/driver_history_screen.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../cubit/driver_home/driver_home_cubit.dart';
import '../cubit/driver_main/driver_main_cubit.dart';
import '../widgets/driver_main_layout/animated_bottom_bar.dart';
import 'driver_home.dart';

class DriverMainLayout extends StatefulWidget {
  final TripModel? tripModel;
  final UserModel? userModel;
  final String? tripUuid;
  final String? tripId;

  const DriverMainLayout({
    super.key,
    this.tripModel,
    this.userModel,
    this.tripUuid,
    this.tripId,
  });

  @override
  State<DriverMainLayout> createState() => _DriverMainLayoutState();
}

class _DriverMainLayoutState extends State<DriverMainLayout> {
  TripModel? currentTripModel;
  bool _isBottomSheetOpen = false;

  List<Widget> screens() {
    return [
      DriverHome(userModel: widget.userModel, tripModel: currentTripModel),
      const TripHistoryScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  void initState() {
    context.read<SocketCubit>().initSocketConnection();
    currentTripModel = widget.tripModel;
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
        iosAppStoreId: "6754820055",
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<DriverMainCubit>()),
          BlocProvider(
            create: (context) => sl<DriverHomeCubit>()
              ..initTrip(model: widget.tripModel, userModel: widget.userModel),
          ),
        ],
        child: BlocConsumer<DriverHomeCubit, DriverHomeState>(
          listener: (context, state) {
            if (state is ReceiveTripRequestState) {
              if (_isBottomSheetOpen) return;

              DriverTripHelper()
                  .showTripBottomNav(
                    context: context,
                    model: state.tripModel,
                    onCancel: () {
                      Future.delayed(const Duration(milliseconds: 700), () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        if (mounted) {
                          setState(() {
                            _isBottomSheetOpen = false;
                            currentTripModel = null;
                          });
                        }
                      });
                    },
                  )
                  .whenComplete(() {
                    if (mounted) {
                      setState(() {
                        _isBottomSheetOpen = false;
                        currentTripModel = null;
                      });
                    }
                  });
              setState(() {
                _isBottomSheetOpen = true;
                currentTripModel = state.tripModel;
              });
            }
          },
          builder: (context, driverHomeState) {
            return BlocBuilder<DriverMainCubit, DriverMainState>(
              builder: (context, state) {
                return Scaffold(
                  body: screens()[context.read<DriverMainCubit>().currentIndex],
                  bottomNavigationBar: const AnimatedBottomBar(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
