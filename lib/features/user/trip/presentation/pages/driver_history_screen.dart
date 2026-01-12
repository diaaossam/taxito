import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/features/user/trip/presentation/bloc/trip_history/trip_history_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/enum/trip_status_enum.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_sliver_app_bar.dart';
import '../widgets/trips_history/driver_trips_history.dart';

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  final ValueNotifier<int> listenableCompany = ValueNotifier(0);

  TripStatusEnum tripStatusEnum = TripStatusEnum.coming;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripHistoryCubit>(),
      child: BlocBuilder<TripHistoryCubit, TripHistoryState>(
        builder: (context, state) {
          final bloc = context.read<TripHistoryCubit>();
          return RefreshIndicator(
            onRefresh: () async {
              if (listenableCompany.value == 0) {
                bloc.commingPagingController.refresh();
              } else if (listenableCompany.value == 1) {
                bloc.deliveredPagingController.refresh();
              } else if (listenableCompany.value == 2) {
                bloc.cancelledPagingController.refresh();
              }
            },
            child: CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  showLeading: false,
                  title: context.localizations.tripHistory,
                ),
                SliverPadding(
                  padding: REdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: ValueListenableBuilder<int>(
                      valueListenable: listenableCompany,
                      builder: (BuildContext context, value, Widget? child) {
                        return Column(
                          children: [
                            CupertinoSlidingSegmentedControl(
                              backgroundColor:
                                  context.colorScheme.inversePrimary,
                              thumbColor: context.colorScheme.primary,
                              children: {
                                0: Container(
                                  padding: const EdgeInsets.all(14),
                                  width: SizeConfig.screenWidth * .3,
                                  child: Center(
                                    child: AppText(
                                      text: context.localizations.coming,
                                      color: listenableCompany.value == 0
                                          ? context.colorScheme.surface
                                          : null,
                                    ),
                                  ),
                                ),
                                1: Container(
                                  padding: const EdgeInsets.all(14),
                                  width: SizeConfig.screenWidth * .3,
                                  child: Center(
                                    child: AppText(
                                      text: context.localizations.completed,
                                      color: listenableCompany.value == 1
                                          ? context.colorScheme.surface
                                          : null,
                                    ),
                                  ),
                                ),
                                2: Container(
                                  padding: const EdgeInsets.all(14),
                                  width: SizeConfig.screenWidth * .3,
                                  child: Center(
                                    child: AppText(
                                      color: listenableCompany.value == 2
                                          ? context.colorScheme.surface
                                          : null,
                                      text: context.localizations.canceled,
                                    ),
                                  ),
                                ),
                              },
                              groupValue: listenableCompany.value,
                              onValueChanged: (value) {
                                if (listenableCompany.value == value) return;
                                listenableCompany.value = value!;
                                TripStatusEnum newStatus;
                                switch (value) {
                                  case 0:
                                    newStatus = TripStatusEnum.coming;
                                    break;
                                  case 1:
                                    newStatus = TripStatusEnum.delivered;
                                    break;
                                  case 2:
                                    newStatus = TripStatusEnum.cancelled;
                                    break;
                                  default:
                                    newStatus = tripStatusEnum;
                                }
                                if (tripStatusEnum != newStatus) {
                                  setState(() {
                                    tripStatusEnum = newStatus;
                                  });
                                }
                              },
                            ),
                            10.verticalSpace,
                          ],
                        );
                      },
                    ),
                  ),
                ),
                if (tripStatusEnum == TripStatusEnum.coming)
                  DriverTripsHistory(
                    key: ValueKey(TripStatusEnum.coming.name),
                    status: TripStatusEnum.waitingDriver.name,
                    pagingController: bloc.commingPagingController,
                  ),
                if (tripStatusEnum == TripStatusEnum.delivered)
                  DriverTripsHistory(
                    key: ValueKey(TripStatusEnum.delivered.name),
                    status: TripStatusEnum.delivered.name,
                    pagingController: bloc.deliveredPagingController,
                  ),
                if (tripStatusEnum == TripStatusEnum.cancelled)
                  DriverTripsHistory(
                    key: ValueKey(TripStatusEnum.cancelled.name),
                    pagingController: bloc.cancelledPagingController,
                    status: TripStatusEnum.cancelled.name,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
