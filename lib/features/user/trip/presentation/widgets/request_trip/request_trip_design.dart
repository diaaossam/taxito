import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:taxito/features/user/trip/presentation/widgets/request_trip/request_trip_time.dart';
import 'package:taxito/features/user/trip/presentation/widgets/scheduled_dailog_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../../../core/enum/trip_status_enum.dart';
import '../../../../../../core/utils/app_constant.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../data/models/trip_model.dart';
import '../../../trip_helper.dart';
import '../../bloc/request_trip/request_trip_info_bloc.dart';
import '../../bloc/trip_info/trip_bloc.dart';
import '../../bloc/trip_info/trip_state.dart';
import '../../pages/searching_for_driver_screen.dart';
import '../found_driver_page/found_driver_page.dart';
import '../rate_driver_page/rate_driver_page.dart';
import 'drivers_not_found.dart';
import 'request_trip_body.dart';

class RequestTripDesign extends StatefulWidget {
  final double height;
  final TripModel? tripModel;
  final int initialIndex;
  final Function(int) onChangeIndex;

  const RequestTripDesign({
    super.key,
    required this.height,
    this.tripModel,
    required this.initialIndex,
    required this.onChangeIndex,
  });

  @override
  State<RequestTripDesign> createState() => RequestTripDesignState();
}

class RequestTripDesignState extends State<RequestTripDesign>
    with WidgetsBindingObserver {
  double height = 0;
  int currentIndex = 0;
  TripModel? tripModel;
  bool _isNavigating = false; // Flag to prevent double navigation
  bool _hasShownPaymentDialog = false; // Prevent showing payment dialog twice
  final GlobalKey _alertKey = GlobalKey();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    tripModel = widget.tripModel;
    currentIndex = widget.initialIndex;
    if (widget.tripModel != null) {
      if (widget.tripModel?.status == TripStatusEnum.waitingDriver) {
        _handleWaitingDriver();
      }

      if (widget.tripModel?.driver != null) {
        // تثبيت ارتفاع الـ bottom sheet لما يكون فيه سائق
        height = SizeConfig.bodyHeight * .32;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        return BlocConsumer<RequestTripBloc, RequestTripState>(
          listener: (context, state) {
            if (state is MakeTripRequestLoading) {
              Navigator.pop(context);
            }
            if (state is MakeTripRequestFailure) {
              AppConstant.showCustomSnakeBar(context, state.msg, false);
            } else if (state is MakeTripRequestSuccess) {
              if (state.tripModel.isSchedule == 1) {
                showDialog(
                  context: context,
                  builder: (context) => const ScheduledDailogDesign(),
                );
                return;
              }
              if (state.tripModel.status == TripStatusEnum.cancelled) {
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => SizedBox(
                    height: SizeConfig.bodyHeight * .6,
                    child: DriversNotFound(tripModel: state.tripModel),
                  ),
                );
                return;
              } else {
                if (_isNavigating) return;
                _isNavigating = true;
                context.navigateTo(
                  SearchingForDriverScreen(tripModel: state.tripModel),
                  callback: (result) {
                    _isNavigating = false;
                    if (result != null) {
                      if (result is TripModel) {
                        if (!mounted) return;
                        if (result.driver == null) {
                          AppConstant.showCustomSnakeBar(
                            context,
                            "Driver information not found. Please try again.",
                            false,
                          );
                          return;
                        }
                        context.read<TripBloc>().clearMarkers();
                        setState(() => tripModel = result);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _handleNavigationToFoundDriverPage(result);
                        });
                      }
                    }
                  },
                );
              }
            }
          },
          builder: (context, state) {
            final double pageViewHeight =
                (height) + widget.height + SizeConfig.bodyHeight * .06;
            return WillPopScope(
              onWillPop: () async {
                return onWillPop();
              },
              child: SizedBox(
                width: SizeConfig.screenWidth,
                height: pageViewHeight,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  child: LazyIndexedStack(
                    key: ValueKey<int>(currentIndex),
                    index: currentIndex,
                    children: [
                      RequestTripBody(
                        onChangeIndex: (p0) =>
                            setState(() => currentIndex = p0),
                      ),
                      const RequestTripTime(),
                      FoundDriverPage(
                        tripModel: tripModel ?? TripModel(),
                        onTripCallBack: (p0) {
                          setState(() {
                            tripModel = p0;
                            if (p0.status == TripStatusEnum.cancelled) {
                              context.navigateToAndFinish(const MainLayout());
                            }
                            if (p0.status == TripStatusEnum.delivered) {
                              setState(() {
                                currentIndex = 3;
                                // تثبيت ارتفاع الـ bottom sheet في حالة التسليم
                                height = SizeConfig.bodyHeight * .34;
                              });
                              _showPendingPaymentDialogIfNeeded(p0);
                            }
                          });
                        },
                      ),
                      if (tripModel != null && currentIndex == 3)
                        RateDriverPage(tripModel: tripModel!)
                      else
                        const Center(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    if (currentIndex == 0) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      return true;
    }
    if (currentIndex == 1) {
      setState(() {
        height = 0;
        currentIndex = 0;
      });
      return false;
    } else {
      setState(() {
        height = SizeConfig.bodyHeight * .1;
        currentIndex = 0;
      });
      return false;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _handleNavigationToFoundDriverPage(
    TripModel result, {
    bool isFromLifeCycle = false,
  }) {
    context.read<TripBloc>().clearMarkers();
    if (result.status == TripStatusEnum.delivered) {
      setState(() {
        tripModel = result;
        currentIndex = 3;
        // تثبيت نفس ارتفاع حالة التسليم حتى لو جت من الـ lifecycle
        height = SizeConfig.bodyHeight * .34;
      });
      _showPendingPaymentDialogIfNeeded(result);
    } else {
      setState(() {
        tripModel = result;
        currentIndex = 2;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      _checkTripStatus();
    }
  }

  Future<void> _checkTripStatus() async {
    final tripUuid = tripModel?.uuid;
    if (tripUuid != null && tripUuid.isNotEmpty) {
      final response = await context.read<TripBloc>().getTripByUUidUseCase(
        uuid: tripUuid,
      );
      response.fold((l) {}, (r) {
        if (r.data != null && r.data.driver != null && mounted) {
          _handleNavigationToFoundDriverPage(r.data, isFromLifeCycle: true);
        }
      });
    }
  }

  void _showPendingPaymentDialogIfNeeded(TripModel model) {
    // لو الدايلوج اتعرض قبل كده في نفس الرحلة، متعرضوش تاني
    if (_hasShownPaymentDialog) return;

    // لو لسه مظهرناش الدايلوج، نتأكد إن فيه فعلاً مبلغ مستحق ووسيلة الدفع
    if (model.paymentMethod == PaymentType.cash) {
      _hasShownPaymentDialog = true;
      TripHelper().showSendPendingPaymentDialog(
        globalKey: _alertKey,
        context: context,
        tripModel: model,
        map: {},
      );
    } else {
      if (model.remaining_price != 0 && model.remaining_price != null) {
        _hasShownPaymentDialog = true;
        TripHelper().showSendPendingPaymentDialog(
          globalKey: _alertKey,
          context: context,
          tripModel: model,
          map: {},
        );
      }
    }
  }

  void _handleWaitingDriver() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 400), () {
        context.navigateTo(
          SearchingForDriverScreen(
            tripModel: widget.tripModel!,
            isCallSocket: true,
          ),
          callback: (result) {
            setState(() => height = SizeConfig.bodyHeight * .3);
            _isNavigating = false;
            if (result != null) {
              if (result is TripModel) {
                if (!mounted) return;
                setState(() => tripModel = result);
                _handleNavigationToFoundDriverPage(result);
              }
            }
          },
        );
      });
    });
  }
}
