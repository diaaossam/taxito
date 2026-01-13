import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../common/models/trip_model.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../../../../widgets/loading/loading_widget.dart';
import '../bloc/searching_for_driver/searching_for_driver_bloc.dart';
import '../widgets/search_for_driver/search_for_driver_bottom_text.dart';

class SearchingForDriverScreen extends StatefulWidget {
  final TripModel tripModel;
  final bool isCallSocket;

  const SearchingForDriverScreen(
      {super.key, required this.tripModel, this.isCallSocket = false});

  @override
  State<SearchingForDriverScreen> createState() =>
      _SearchingForDriverScreenState();
}

class _SearchingForDriverScreenState extends State<SearchingForDriverScreen>
    with WidgetsBindingObserver {
  final bloc = sl<SearchingForDriverBloc>();
  bool _isScreenActive = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _isScreenActive && mounted) {
      _checkTripStatus();
    }
  }

  Future<void> _checkTripStatus() async {
    try {
      final tripUuid = widget.tripModel.uuid;
      if (tripUuid != null && tripUuid.isNotEmpty) {
        final response = await bloc.getTripByUUidUseCase(uuid: tripUuid);
        response.fold(
          (l) {
            if (kDebugMode) {
              print('Error checking trip status: ${l.msg}');
            }
          },
          (r) {
            if (r.data.driver != null && mounted && _isScreenActive) {
              Navigator.pop(context, r.data);
            }
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in _checkTripStatus: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider.value(
        value: bloc
          ..onInitializeSocket(
              tripId: widget.tripModel.id ?? 0,
              isCallSocket: widget.isCallSocket,
              uuid: widget.tripModel.uuid ?? ''),
        child: BlocConsumer<SearchingForDriverBloc, SearchingForDriverState>(
          listener: (context, state) {
            if (state is CancelTripFailure) {
              AppConstant.showCustomSnakeBar(context, state.errorMsg, false);
            } else if (state is CancelTripSuccess) {
              Navigator.of(context).pop();
            } else if (state is DriverFound) {
              Navigator.of(context).pop(state.tripModel);
            } else if (state is SearchForDriverFailure) {
              context.navigateToAndFinish(const MainLayout());
              AppConstant.showCustomSnakeBar(context, state.msg, false);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.bodyHeight * .1),
                      AppText(
                        text: context.localizations.searchingForDriverTitle,
                        fontWeight: FontWeight.w600,
                        textSize: 18,
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * .02),
                      AppText(
                        text: context.localizations.searchingForDriverBody,
                        textSize: 16,
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * .15),
                      AppImage.asset(
                        Assets.images.searchingForDriver.path,
                        height: SizeConfig.bodyHeight * .35,
                        width: SizeConfig.bodyHeight * .35,
                      ),
                      const Spacer(),
                      if (state is CancelTripLoading)
                        const LoadingWidget(size: 35)
                      else
                        Padding(
                          padding: screenPadding(),
                          child: CustomButton(
                            text: context.localizations.cancelDriver,
                            press: () => context
                                .read<SearchingForDriverBloc>()
                                .cancelTrip(
                                    tripId: widget.tripModel.id ?? 0,
                                    uuid: widget.tripModel.uuid ?? ''),
                            backgroundColor: Colors.transparent,
                            textColor: context.colorScheme.primary,
                          ),
                        ),
                      SizedBox(height: SizeConfig.bodyHeight * .04),
                      SearchForDriverBottomText(
                        callback: () => context
                            .read<SearchingForDriverBloc>()
                            .cancelTrip(
                                tripId: widget.tripModel.id ?? 0,
                                uuid: widget.tripModel.uuid ?? ''),
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * .04),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isScreenActive = false;
    WidgetsBinding.instance.removeObserver(this);
    try {
      bloc.socketService.disconnectFromRoomEvent("trip-accepted");
      bloc.socketService.disconnectFromRoomEvent("trip-rejected");
    } catch (_) {}
    bloc.close();
    super.dispose();
  }
}

/*
class SearchingForDriverScreen extends StatefulWidget {
  final TripModel tripModel;
  final bool isCallSocket;

  const SearchingForDriverScreen(
      {super.key, required this.tripModel, this.isCallSocket = false});

  @override
  State<SearchingForDriverScreen> createState() =>
      _SearchingForDriverScreenState();
}

class _SearchingForDriverScreenState extends State<SearchingForDriverScreen> with WidgetsBindingObserver {
  final bloc = sl<SearchingForDriverBloc>();
  bool _isScreenActive = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _isScreenActive && mounted) {
      _checkTripStatus();
    }
  }

  Future<void> _checkTripStatus() async {
    try {
      final tripUuid = widget.tripModel.uuid;
      if (tripUuid != null && tripUuid.isNotEmpty) {
        final response = await bloc.getTripByUUidUseCase(uuid: tripUuid);
        response.fold(
              (l) {
            if (kDebugMode) {
              print('Error checking trip status: ${l.msg}');
            }
          },
              (r) {
            if (r.data.driver != null && mounted && _isScreenActive) {
              Navigator.pop(context, r.data);
            }
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in _checkTripStatus: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider.value(
        value: bloc..add(ListenForAcceptedDriverEvent(
              tripModel: widget.tripModel,
              context: context,
              isCallSocket: widget.isCallSocket)),
        child: BlocConsumer<SearchingForDriverBloc, SearchingForDriverState>(
          listener: (context, state) {
            if (state is CancelTripFailure) {
              AppConstant.showCustomSnakeBar(context, state.errorMsg, false);
            } else if (state is CancelTripSuccess) {
              context.navigateToAndFinish(const HomeLayout());
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.bodyHeight * .1),
                      AppText(
                        text: context.localizations.searchingForDriverTitle,
                        fontWeight: FontWeight.w600,
                        textSize: 18,
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * .02),
                      AppText(
                        text: context.localizations.searchingForDriverBody,
                        textSize: 16,
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * .15),
                      AppImage.asset(
                        Assets.images.searchingForDriver.path,
                        height: SizeConfig.bodyHeight * .35,
                        width: SizeConfig.bodyHeight * .35,
                      ),
                      const Spacer(),
                      if (state is CancelTripLoading)
                        const LoadingWidget(size: 35)
                      else
                        Padding(
                          padding: screenPadding(),
                          child: CustomButton(
                            text: context.localizations.cancelDriver,
                            press: () {
                              showCupertinoModalBottomSheet(
                                context: context,
                                builder: (dialogContext) =>
                                    CancelTripConfirmationDialog(
                                      onConfirmCancel: () async {
                                        context.read<SearchingForDriverBloc>().add(
                                            CancelTripEvent(
                                                noDriver: false,
                                                tripId: widget.tripModel.id ?? 0,
                                                tripModel: widget.tripModel));
                                      },
                                    ),
                              );
                            },
                            backgroundColor: Colors.transparent,
                            textColor: context.colorScheme.primary,
                          ),
                        ),
                      SizedBox(height: SizeConfig.bodyHeight * .04),
                      SearchForDriverBottomText(
                        callback: () {
                          if (_isScreenActive && mounted) {
                            showCupertinoModalBottomSheet(
                              context: context,
                              builder: (dialogContext) =>
                                  CancelTripConfirmationDialog(
                                    onConfirmCancel: () async {
                                      context.read<SearchingForDriverBloc>().add(
                                        CancelTripEvent(
                                            noDriver: true,
                                            tripModel: widget.tripModel,
                                            tripId: widget.tripModel.id ?? 0),
                                      );
                                    },
                                  ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: SizeConfig.bodyHeight * .04),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _isScreenActive = false;
    WidgetsBinding.instance.removeObserver(this);
    try {
      bloc.socketService.disconnectFromRoomEvent("trip-accepted");
      bloc.socketService.disconnectFromRoomEvent("trip-rejected");
    } catch (_) {}
    bloc.close();
    super.dispose();
  }
}

*/
