import 'package:taxito/core/enum/trip_status_enum.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/trip/presentation/widgets/trips_history/driver_trip_item.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../data/models/trip_model.dart';
import '../../bloc/trip_actions_cubit.dart';
import '../../bloc/trip_history/trip_history_cubit.dart';
import '../../pages/driver_history_details_screen.dart';
import '../../pages/request_trip_screen.dart';
import 'empty_trips_history.dart';

class DriverTripsHistory extends StatefulWidget {
  final String status;
  final PagingController<int, TripModel> pagingController;

  const DriverTripsHistory({
    super.key,
    required this.status,
    required this.pagingController,
  });

  @override
  State<DriverTripsHistory> createState() => _DriverTripsHistoryState();
}

class _DriverTripsHistoryState extends State<DriverTripsHistory> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<TripHistoryCubit>();
    widget.pagingController.addPageRequestListener((pageKey) {
      bloc.fetchPage(pageKey, widget.status, widget.pagingController,
          widget.status == "pending");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripActionsCubit>(),
      child: BlocConsumer<TripActionsCubit, TripActionsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final bloc = context.read<TripActionsCubit>();
          return SliverPadding(
            padding: screenPadding(),
            sliver: PagedSliverList(
                pagingController: widget.pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  firstPageProgressIndicatorBuilder: (context) =>
                      const LoadingWidget(),
                  noItemsFoundIndicatorBuilder: (context) =>
                      const EmptyTripsHistoryWidget(),
                  itemBuilder: (context, TripModel item, index) =>
                      DriverTripItem(
                    tripModel: item,
                    isDriver: false,
                    onGetDetails: (p0) => context.navigateTo(
                        DriverHistoryDetailsScreen(tripModel: item)),
                    onCancel: item.status == TripStatusEnum.waitingDriver
                        ? (value) => bloc.cancelTrip(id: item.id ?? 0)
                        : null,
                    onSearch: item.status == TripStatusEnum.waitingDriver
                        ? (value) => context.navigateTo(RequestTripScreen(
                              tripModel: item,
                            ))
                        : null,
                  ),
                )),
          );
        },
      ),
    );
  }
}
